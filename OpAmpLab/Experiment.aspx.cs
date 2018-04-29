using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NationalInstruments.DAQmx;
using System.Runtime.InteropServices;

namespace OpAmpLab
{
    public partial class Experiment : System.Web.UI.Page
    {

            double[] result = new double[1000];
            double[] result1 = new double[1000];
            protected void Page_Load(object sender, EventArgs e)
            {
                AmplitudeNumericEdit.Value = AmplitudeKnob.Value;
                FrequencyNumericEdit.Value = FrequencyKnob.Value;
                AmplitudeKnob.Value = AmplitudeNumericEdit.Value;
                FrequencyKnob.Value = FrequencyNumericEdit.Value;
            }

            protected void AddDeviceButton_Click(object sender, EventArgs e)
            {
                AddDeviceButton.Enabled = false;

                //List devices
                string[] deviceList = DaqSystem.Local.Devices;

                foreach (string currentDevice in deviceList)
                {
                    ListItem Devices = new ListItem(currentDevice);
                    Devices.Selected = true;
                    AvailableDeviceDropDownList.Items.Add(Devices);
                }

                AddDeviceButton.Enabled = true;
            }
            protected void PlotGraphButton_Click(object sender, EventArgs e)
            {
                PInvoke4.Run();

                //convert inputs to values the LabVIEW dll wil use
                ushort signal = Convert.ToUInt16(SignalDropDownList.SelectedIndex);
                double amplitude = Convert.ToDouble(AmplitudeNumericEdit.Value);
                double frequency = Convert.ToDouble(FrequencyNumericEdit.Value);
                string device = DaqSystem.Local.Devices[AvailableDeviceDropDownList.SelectedIndex];

                PInvoke.SetParameters(signal, device, frequency, amplitude);

                PInvoke2.GetValues(result, 1000);
                for (int i = 0; i < 1000; i++)
                {
                    Scope.Plots[0].PlotY(result);
                }

                PInvoke1.GetValuesOut(result1, 1000);
                for (int i = 0; i < 1000; i++)
                {
                    Scope.Plots[1].PlotY(result1);
                }
            }



            protected void ViewOutputButton_Click(object sender, EventArgs e)
            {
                Scope.ClearData();
                PInvoke2.GetValues(result, 1000);
                for (int i = 0; i < 1000; i++)
                {
                    Scope.Plots[0].PlotY(result);
                }
            }

            protected void ViewInputButton_Click(object sender, EventArgs e)
            {
                Scope.ClearData();
                PInvoke1.GetValuesOut(result1, 1000);
                for (int i = 0; i < 1000; i++)
                {
                    Scope.Plots[1].PlotY(result1);
                }
            }
    }        

        public static class PInvoke
        {
            [DllImport("E:\\Recitification\\MyDLL\\SharedLib.dll", CallingConvention = CallingConvention.StdCall, EntryPoint = "SetParameters")]
            public static extern void SetParameters(ushort Type, string DeviceName, double FrequencyHz, double AmplitudeVpp);
        }
        public static class PInvoke2
        {

            [DllImport("E:\\Recitification\\MyDLL\\SharedLib.dll", CallingConvention = CallingConvention.StdCall, EntryPoint = "GetValues")]
            public static extern void GetValues(double[] Amp1, int len);
        }

        public static class PInvoke4
        {

            [DllImport("E:\\Recitification\\MyDLL\\SharedLib.dll", CallingConvention = CallingConvention.StdCall, EntryPoint = "Run")]
            public static extern void Run();
        }

        public static class PInvoke1
        {

            [DllImport("E:\\Recitification\\MyDLL\\SharedLib.dll", CallingConvention = CallingConvention.StdCall, EntryPoint = "GetValuesOut")]
            public static extern double GetValuesOut(double[] Amp2, int len);
        }
    
}