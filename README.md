# AI_Compliance_Flutter 🖥️📖👍🏼

To run the project frontend, Flutter needs to be installed on the system for the frontend. Flutter can be downloaded and installed from the following link:

https://docs.flutter.dev/install

To run the backend, Python version 3.10 is needed. the following packages that can be installed with "pip install <package name>" need to be installed on Python also:

fastapi 
uvicorn
sqlalchemy
dotenv
nltk
openai
PyPDF2
python-multipart 
pymySQL


To run this program, the OPENAI_API_KEY variable needs to be setx` on the environment variables using "export"

Make sure the table to store the data follows the correct data types such as the following

 CREATE TABLE IF NOT EXISTS violations (
            id INT AUTO_INCREMENT PRIMARY KEY,
            person_id VARCHAR(255),
            person_role VARCHAR(255),
            incident_file VARCHAR(255),
            decision VARCHAR(255) NOT NULL,
            violation_result_text TEXT,
            severity VARCHAR(255),
            severity_reason TEXT,
            sanction_level VARCHAR(255),
            recommended_action TEXT,
            sanction_reason TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );

On two separate terminals, run in order the following:

1. to run the backend, cd into backend and run "uvicorn app:app --reload --port 8002"

2. To run the flutter frontend, to cd into frontend and run "flutter run -d chrome"


ensure it is on the 8002 and port.

Any questions email amiralimoin@cmail.carleton.ca or fshok080@uottawa.ca
