Sub TranslateText()
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets("Situationen")  ' Blattname anpassen

    Dim startRow As Integer: startRow = 14  ' Startzeile anpassen
    Dim colText As Integer: colText = 4    ' Spalte mit dem zu übersetzenden Text
    Dim colTrans As Integer: colTrans = 5  ' Ziel-Spalte für die Übersetzung

    Dim lastRow As Integer
    lastRow = ws.Cells(ws.Rows.Count, colText).End(xlUp).Row

    Dim i As Integer
    For i = startRow To lastRow
        If ws.Cells(i, colText).Value <> "" Then
            ws.Cells(i, colTrans).Value = TranslateWithDeepL(ws.Cells(i, colText).Value)
        End If
    Next i
End Sub

' Function to read the API key from the configuration file
Function ReadApiKey() As String
    Dim filePath As String
    filePath = ThisWorkbook.Path & "\api-key.txt"  ' Adjust the path if needed

    Dim apiKey As String
    Open filePath For Input As #1
    Line Input #1, apiKey
    Close #1

    ' Trim to remove leading/trailing spaces
    ReadApiKey = Trim(apiKey)
End Function

Function TranslateWithDeepL(text As String) As String
    On Error GoTo ErrorHandler
    Dim xmlhttp As New MSXML2.XMLHTTP60, myurl As String
    myurl = "https://api-free.deepl.com/v2/translate?auth_key="&ReadApiKey()&"&text=" & _
            URLEncode(text) & "&target_lang=EN&source_lang=DE"

    xmlhttp.Open "POST", myurl, False
    xmlhttp.send

    Dim response As String
    response = xmlhttp.responseText

    ' Debug-Ausgabe der Antwort
    Debug.Print "API Response: " & response

    ' JSON Parsing (verbessert)
    Dim json As Object
    Set json = JsonConverter.ParseJson(response)

    ' Überprüfen, ob die Antwort den übersetzten Text enthält
    If json("translations").Count > 0 Then
        TranslateWithDeepL = json("translations")(1)("text")
    Else
        TranslateWithDeepL = "Kein übersetzter Text gefunden"
    End If

    Exit Function

ErrorHandler:
    Debug.Print "Fehler in TranslateWithDeepL: " & Err.Description
    TranslateWithDeepL = "Fehler beim Übersetzen: " & Err.Description
End Function

Function URLEncode(StringVal As String, Optional SpaceAsPlus As Boolean = False) As String
    Dim StringLen As Long: StringLen = Len(StringVal)

    If StringLen > 0 Then
        ReDim result(StringLen) As String
        Dim i As Long, CharCode As Integer
        Dim Char As String, Space As String

        If SpaceAsPlus Then Space = "+" Else Space = "%20"

        For i = 1 To StringLen
            Char = Mid$(StringVal, i, 1)
            CharCode = Asc(Char)

            Select Case CharCode
                Case 97 To 122, 65 To 90, 48 To 57
                    result(i) = Char
                Case 32
                    result(i) = Space
                Case Else
                    result(i) = "%" & Hex(CharCode)
            End Select
        Next i

        URLEncode = Join(result, "")
    End If
End Function