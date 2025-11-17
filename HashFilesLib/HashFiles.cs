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
            var result = new StringBuilder();
            var fileCount = 0;

            // Check inputs are not null
            if (string.IsNullOrEmpty(sourcePath) || string.IsNullOrEmpty(destinationPath))
            {
                return "Error: Please enter both a Source and Destination Path";
            }
            try
            {

                Directory.CreateDirectory(destinationPath);

                // Find each file in source directly and generate hash
                foreach (string file in Directory.GetFiles(sourcePath))
                {
                    result.Append(GetHashedFile(sourcePath, Path.GetFileName(file), destinationPath));
                    fileCount++;
                }
                result.AppendLine( $"Completed Sucessfully - {fileCount} files found");
                return result.ToString();

            }
            catch (Exception e)
            {
                return $"Error: {e.Message}";
            }


        }


        // Get Hashed files for a specific file in a directory
        public static String GetHashedFile(string sourcePath, string fileName, string destinationPath)
        {
            var result = new StringBuilder();
            var sourceFile = Path.Combine(sourcePath, fileName);
            try
            {
               
                Directory.CreateDirectory(destinationPath);

                // Find each file in source directly and generate hash
                return GenerateHashedFile(sourcePath, fileName, destinationPath);
 
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
            var destinationFile = Path.Combine(destinationPath, $"{fileName}H");
            var result = new StringBuilder();

            // check file is not blank
            if (lines.Length == 0)
            {
                return $"No data found in file: {sourceFile}";
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

                        result.AppendLine($"Generated Hashed File: {destinationFile}");
                    }
                    catch (Exception e)
                    {
                        return $"Error: {e.Message} Parsing file:{sourceFile} ";
                    }
                }
            }

            return result.ToString();
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
                byte[] hashBytes = sha.ComputeHash(Encoding.UTF8.GetBytes(line));
                return BitConverter.ToString(hashBytes).Replace("-", "");
            }
        }
    }
}
