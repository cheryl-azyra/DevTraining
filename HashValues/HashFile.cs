using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Threading;


namespace HashValues
{
    internal class HashFile
    {
        static void Main(string[] args)
        {

            // Set some variables
            var sourcePath = "";
            var destinationPath = "";

            // Get source directory from user 
            do
            {

                Console.WriteLine("Enter the Source Directory (or 'exit' to exit): ");
                sourcePath = Console.ReadLine();

                if(string.Equals(sourcePath.ToLower(),"exit"))
                {
                    Console.WriteLine("Exiting program...");
                    Environment.Exit(0);
                }
                // Check source directory exists - if not exit. 
                if (!Directory.Exists(sourcePath))
                {

                    Console.WriteLine($"Source Directory not found: {sourcePath}");

                }

            } while (!Directory.Exists(sourcePath));

            // Get destiantion directory from user
            Console.WriteLine("Enter the Destination Directory: ");
            destinationPath = Console.ReadLine();
            Directory.CreateDirectory(destinationPath);

            // Find each file in source directly and generate hash
            foreach (string file  in Directory.GetFiles(sourcePath))
            {
               var result =  GenerateHashedFile(sourcePath, Path.GetFileName(file), destinationPath);
                Console.WriteLine(result);
            }

            Console.WriteLine($"Completed Hash Program. Will close in 30 seconds");
            Thread.Sleep(30000);

        }

        // Take a source file,generate a hashed version, and save to destination.
        // Generate Hash by taking the sum of (position * ascii encoding) for each character on line
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

                        result.Append($"Generated Hashed File: {destinationFile}");
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
                hash +=  ((i + 1) * (int)line[i]);

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