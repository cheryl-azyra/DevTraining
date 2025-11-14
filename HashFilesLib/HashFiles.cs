using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace HashFilesLib
{
    public class HashFiles
    {
        // Get Hashed files for every file in a directory
        public static String GetHashedFiles(string sourcePath, string destinationPath)
        {
            var result = "";
            var fileCount = 0;

            // Check inputs are not null
            if (sourcePath == "" || destinationPath == "")
            {
                return "Error: Please enter both a Source and Destination Path";
            }
            try
            {

                Directory.CreateDirectory(destinationPath);

                // Find each file in source directly and generate hash
                foreach (string file in Directory.GetFiles(sourcePath))
                {
                    result += GetHashedFile(sourcePath, Path.GetFileName(file), destinationPath) + Environment.NewLine;
                    fileCount++;
                }
                result += $"Completed Sucessfully - {fileCount} files found" ;
                return result;

            }
            catch (Exception e)
            {
                return $"Error: {e.Message}";
            }


        }


        // Get Hashed files for a specific file in a directory
        public static String GetHashedFile(string sourcePath, string fileName, string destinationPath)
        {
            var result = "";
            var sourceFile = Path.Combine(sourcePath, fileName);
            try
            {
               
                Directory.CreateDirectory(destinationPath);

                // Find each file in source directly and generate hash
                result += GenerateHashedFile(sourcePath, fileName, destinationPath);

                return result;
            }catch(FileNotFoundException e)
            {
                return $"Error: Source file does not exist - {sourceFile}";
            }
        }


        // Take a source file,generate a hashed version, and save to destination.
        public static string GenerateHashedFile(string sourcePath, string fileName, string destinationPath)
        {
            var sourceFile = Path.Combine(sourcePath, fileName);
            var lines = File.ReadAllLines(sourceFile);
            var destinationFile = Path.Combine(destinationPath, fileName + "H");
            var result = "";

            // check file is not blank
            if (lines.Length == 0)
            {
                result = $"No data found in file: {sourceFile}";
                return result;
            }
            else
            {
                //  Process file and create hashed version
                using (StreamWriter writer = new StreamWriter(destinationFile))
                {
                    try
                    {
                        foreach (string line in lines)
                        {

                            writer.WriteLine(line.TrimEnd() + "#" + GetSHA256HashStringValue(line.TrimEnd()));

                        }

                        result = $"Generated Hashed File: {destinationFile}";
                    }
                    catch (Exception e)
                    {
                        return $"Error: {e.Message} Parsing file:{sourceFile} ";
                    }
                }
            }

            return result;
        }

        // Get hashed value of the line
        public static string GetHashStringValue(string line)
        {
            var hash = 0;
            // Calculate hash for each charcter
            for (int i = 0; i < line.Length; i++)
            {
                hash += ((i + 1) * (int)line[i]);

            }
            return hash.ToString();
        }

        // Get hashed value of the line
        // Generate Hash by converting line to bytes and using SHA-256 hash to create unique value
        // Return has in hexidecimal form.
        public static string GetSHA256HashStringValue(string line)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(line);
                byte[] hashBytes = sha.ComputeHash(bytes);

                string hash = "";
                // Calculate hash for each charcter
                foreach (byte b in hashBytes)
                {
                    hash += b.ToString("x2");

                }
                return hash.ToString();
            }
        }
    }
}
