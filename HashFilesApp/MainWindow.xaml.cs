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
            if (sourceFileNameTB.Text == "")
            {

                ResultText.Content = HashFilesLib.HashFiles.GetHashedFiles(sourcePathTB.Text, sourcePathTB.Text + @"\Output");

            }
            else
            {

                ResultText.Content = HashFilesLib.HashFiles.GetHashedFile(sourcePathTB.Text, sourceFileNameTB.Text, sourcePathTB.Text + @"\Output");

            }

            ResultText.Visibility = Visibility.Visible;

        }
    }
}
