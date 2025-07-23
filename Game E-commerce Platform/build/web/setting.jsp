<%-- 
    Document   : setting
    Created on : Mar 25, 2025, 7:24:10 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Game Settings</title>
        <style>
            body { 
                font-family: Arial, sans-serif; 
                background: url('assets/image/1551360_383.jpg') no-repeat center center fixed;
                background-size: cover;
                margin: 0;
                padding: 0;
            }
            
            .container { 
                width: 50%; 
                margin: auto; 
                padding: 20px; 
                border: 1px solid #ddd; 
                border-radius: 10px; 
                background: #f9f9f9; 
            }
            
            label { 
                font-weight: bold; 
                display: block; 
                margin-top: 10px; 
            }
            
            input, select { 
                width: 100%; 
                padding: 8px; 
                margin-top: 5px; 
            }
            
            button { 
                margin-top: 15px; 
                padding: 10px; 
                background: blue; 
                color: white; 
                border: none; 
                cursor: pointer; 
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Game Settings</h2>
            <form action="saveSetting.jsp" method="POST">
                
                <h3>General Settings</h3>
                <label>Website Name:</label>
                <input type="text" name="websiteName" value="MyGame Web">
                
                <label>Web Name:</label>
                <input type="text" name="gameName" value="The Best Game Online">

                <label>Web Version:</label>
                <input type="text" name="version" value="1.0.0">
                
                <label>Language:</label>
                <select name="language">
                    <option value="en">English</option>
                    <option value="vi">Vietnamese</option>
                    <option value="jp">Japanese</option>
                </select>

                <h3>Server Settings</h3>
                <label>Server IP:</label>
                <input type="text" name="serverIp" value="192.168.1.1">

                <label>Port:</label>
                <input type="number" name="port" value="8080">

                <button type="submit">Save Settings</button>
            </form>
        </div>
    </body>
</html>

