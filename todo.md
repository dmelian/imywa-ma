TODO LIST
---------

- Open and check the turn before load de select pannel.
- If the database is not found no errors are generated.



IMPROVEMENTS
------------

- session var. Use global session mysql variables defined at the php application class. 
	Before the store procedure call all this variables are passed to mysql like session variables
	on the same sentence we create the @errorNo or @sessionId.
	for example the business and the pos variables in then pos module.
