#!C:\Python37-32\python.exe
print("Content-Type: text/html")
print()

import cgi,cgitb, pymysql


# connect to web server to retain sql inputed by user
cgitb.enable() # for debugging
form = cgi.FieldStorage()

fname = form.getvalue("fname") 
lname = form.getvalue("lname") 
id = form.getvalue("ID") 
idtype = form.getvalue("IDtype") 
age = form.getvalue("age")
roompreference = form.getvalue("roompreference")
foodallergy = form.getvalue("foodallergy") 
sql = """INSERT INTO Customer (cid,id_type,first_name,last_name,age,room_preferences,food_allergy) VALUES("{0}", "{1}", "{2}", "{3}", {4}, "{5}", "{6}");""".format(id, idtype, fname, lname, int(age), roompreference, foodallergy)


db = pymysql.connect("localhost","root","200900302xyz","hotel" )
#Start a cursor object using cursor() method
cursor = db.cursor()
#Execute a SQL query using execute() method. 
cursor.execute(sql)
db.commit()
db.close()

print ('<html>')
print ('<body>')
# #add select this customer information to return as confirmation") 
print("<p>Customer has been successfully added!</p>")
print("<button onclick = \"window.history.back()\">Add New Customer</button>")
print ('</body>')
print ('</html>')

