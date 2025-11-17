using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using HashFilesLib;
using System.IO;

namespace HashFilesApp
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        // Triggered when the user selects Hash button
        // Calls class library to hash all files from sourcePath and output them to the destinationPath
        public void GenerateHashedFile(object sender, RoutedEventArgs e)
        {
            var destinationPath = System.IO.Path.Combine(sourcePathTB.Text, "Output");
            if (string.IsNullOrEmpty(sourceFileNameTB.Text))
            {
  
                ResultText.Content = HashFilesLib.HashFiles.GetHashedFiles(sourcePathTB.Text, destinationPath);

            }
            else
            {

                ResultText.Content = HashFilesLib.HashFiles.GetHashedFile(sourcePathTB.Text, sourceFileNameTB.Text, System.IO.Path.Combine(sourcePathTB.Text, destinationPath));

            }

            ResultText.Visibility = Visibility.Visible;

        }
    }
}
