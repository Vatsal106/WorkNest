<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Client</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        /* Set body background to white */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: #fff; /* White background */
            padding: 20px;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            width: 90%;
            max-width: 1000px;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
        }

        .left-section {
            width: 40%;
            background: #0D0D30;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .left-section img {
            max-width: 100%;
            height: auto;
            object-fit: cover;
            border-radius: 10px;
        }

        .right-section {
            width: 60%;
            padding: 40px;
            display: flex;
            flex-direction: column;
            background: #8B9EB2;
        }

        .form-container {
            width: 100%;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        .input-group {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }

        label {
            flex: 1;
            font-weight: bold;
            font-size: 16px;
            min-width: 150px;
        }

        input {
            flex: 2;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            width: 100%;
        }

        .submit-btn {
            width: 100%;
            padding: 12px;
            background: #007BFF;
            border: none;
            color: white;
            font-size: 18px;
            cursor: pointer;
            border-radius: 5px;
            transition: 0.3s;
        }

        .submit-btn:hover {
            background: #0056b3;
        }

        /* Responsive Design */

        /* LAPTOP (1024px - 1440px) */
        @media (max-width: 1440px) {
            .container {
                width: 85%;
            }
            
            .right-section {
                padding: 30px;
            }
        }

        /* TABLET (768px - 1023px) */
        @media (max-width: 1023px) {
            .container {
                flex-direction: column;
            }

            .left-section {
                width: 100%;
                padding: 20px;
            }

            .right-section {
                width: 100%;
                padding: 25px;
            }

            .input-group {
                flex-direction: column;
                align-items: flex-start;
            }

            label {
                margin-bottom: 5px;
            }
        }

        /* PHONE (480px - 767px) */
        @media (max-width: 767px) {
            body {
                padding: 10px;
            }

            .container {
                width: 95%;
            }

            .left-section {
                padding: 15px;
            }

            .right-section {
                padding: 20px;
            }

            label {
                font-size: 14px;
            }

            input {
                font-size: 14px;
                padding: 8px;
            }

            .submit-btn {
                font-size: 16px;
                padding: 10px;
            }
        }

        /* SMALL PHONE (below 480px) */
        @media (max-width: 480px) {
            .container {
                width: 100%;
                box-shadow: none;
            }

            .left-section {
                padding: 10px;
            }

            .right-section {
                padding: 15px;
            }

            label {
                font-size: 13px;
            }

            input {
                font-size: 13px;
                padding: 6px;
            }

            .submit-btn {
                font-size: 14px;
                padding: 8px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="left-section">
            <img src='<%= ResolveUrl("~/Images/ClientPagePhoto.png") %>' alt="Client Image" />
        </div>

        <div class="right-section">
            <div class="form-container">
                <h2>Add Client</h2>
                
                <div class="input-group">
                    <label>Client Name:</label>
                    <input type="text" placeholder="Enter Client Name">
                </div>
                
                <div class="input-group">
                    <label>Email:</label>
                    <input type="email" placeholder="Enter Email">
                </div>

                <div class="input-group">
                    <label>Phone Number:</label>
                    <input type="text" placeholder="Enter Phone Number">
                </div>

                <div class="input-group">
                    <label>Company Name:</label>
                    <input type="text" placeholder="Enter Company Name">
                </div>

                <div class="input-group">
                    <label>Address:</label>
                    <input type="text" placeholder="Enter Address">
                </div>

                <button class="submit-btn">Submit</button>
            </div>
        </div>
    </div>

</body>
</html>
