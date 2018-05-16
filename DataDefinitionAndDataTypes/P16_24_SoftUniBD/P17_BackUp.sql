  
BACKUP DATABASE SoftUniDB   
   TO DISK = 'C:\Users\lugeorgiev\Documents\Programming\SoftUni-backup.bak'   

USE master
DROP DATABASE SoftUniDB

RESTORE DATABASE SoftUniDB 
FROM DISK = 'C:\Users\lugeorgiev\Documents\Programming\SoftUni-backup.bak'   
   
USE SoftUniDB
SELECT*FROM Adresses