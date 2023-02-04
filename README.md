# CrispSwiftUI
This is a sample project created for the purpose of displaying swiftUI functions clean and crisp. 


- For BackgroundImageUploading project In case you want to perform live tests locally & (Quickly) followings are the Prerequisits.

	Prerequisites: 

	1. Install Python 3.8 using 

			 $ sudo apt-get update
			 $ sudo apt-get install python3.8

					or

			$ brew update 
			$ brew install python

	2. Install ‘FLASK’ in your python environment by

 			pip3 install Flask

	3. Create a Folder with the name of your choice 

	4. Create a new python File with extension .py and Add the following code to it and then save the file it will take care of the rest 

            from flask import Flask, request
            from werkzeug.utils import secure_filename
            import os
            UPLOAD_FOLDER = 'uploads'
            if not os.path.exists(UPLOAD_FOLDER):
            os.makedirs(UPLOAD_FOLDER)
            app = Flask(__name__)
            app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
            @app.route('/upload', methods=['POST'])
            def upload_file():
            file = request.files.get('file')
            name = request.form.get('name')
            age = request.form.get('age')
            print(request)
            print(age,name)
            print(file)
            if file:
            # Do something with the file, such as saving it to disk
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            return 'File uploaded successfully with name: {}, age: {}'.format(name, age)
            return 'No file was uploaded'
            if __name__ == '__main__':
                app.run(debug=True)


5. Navigate (type command cd ) to the directory where your app.py is stored 

6. Type - "pip3 run python app.py”

7. That’s it:  if steps successfully followed you will get a server URL just paste it in our Xcode Project BackgroundImageUpload

8. Run the iOS app on physical device and simulator and check the images, timings and results. You should see something like this

<img width="1440" alt="Screenshot 2023-02-04 at 4 59 39 PM" src="https://user-images.githubusercontent.com/15359399/216788228-7574f569-07a5-4344-91c6-717a467e3923.png">

