Set objMail = CreateObject("CDO.Message")
Set objConf = CreateObject("CDO.Configuration")
Set objFlds = objConf.Fields
objFlds.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'cdoSendUsingPort
objFlds.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "mail.mitchell.com" 'your smtp server domain or IP address goes here
objFlds.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 'default port for email
'uncomment next three lines if you need to use SMTP Authorization
'objFlds.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "your-username"
'objFlds.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "your-password"
'objFlds.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'cdoBasic
objFlds.Update
objMail.Configuration = objConf
'objMail.FromName = "Sambhav Patni"
objMail.From = "IEFAlert@mitchell.com"
objMail.To = "sambhav.patni@mitchell.com"
objMail.Subject = "Mismatch Alert IEFMon(CADSSP)"
objMail.HTMLBody = "<H3>Please review: IEF process missed files.</H3>PFA: List of files Missing in DB<BR/><BR/>Thanks,<BR/>IEFMon by Sambhav"
objMail.AddAttachment "C:\sam\Report_Integrrated_Process\FLModule\LSDIFF.txt"
objMail.Send
Set objFlds = Nothing
Set objConf = Nothing
Set objMail = Nothing