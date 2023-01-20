INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_mecano','Mécano',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_mecano','Mécano',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_mecano', 'Mécano', 1)
;

INSERT INTO `jobs` (`name`, `label`) VALUES
('mecano', 'Mécano');


INSERT INTO `job_grades` (id, job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('90', 'mecano',0,'recrue','Recrue',12,'{}','{}'),
	('91', 'mecano',1,'novice','Novice',24,'{}','{}'),
	('92', 'mecano',2,'experimente','Experimente',36,'{}','{}'),
	('93', 'mecano',3,'chief',"Chef d\'équipe",48,'{}','{}'),
	('94', 'mecano',4,'boss','Patron',0,'{}','{}')
;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES ('piecedetache', 'Pièce Détacher', '-1', '0', '1'), ('repairkit', 'Kit de réparation', '-1', '0', '1') 




