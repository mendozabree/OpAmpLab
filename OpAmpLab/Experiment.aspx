<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Experiment.aspx.cs" Inherits="OpAmpLab.Experiment" %>

<%@ Register Assembly="NationalInstruments.UI.WebForms, Version=15.0.45.49153, Culture=neutral, PublicKeyToken=4febd62461bf11a4" Namespace="NationalInstruments.UI.WebForms" TagPrefix="ni" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>OpAmp</title>
    <link href="Content/bootstrap4.min.css" rel="stylesheet" />
    <style>
        .container
        {
            padding-top: 20px;
        }
        .Display
        {
            background-color:black;
            font-size:xx-large; 
            height: 65px;
            width: 242px;
        }
        .Edit
        {
            margin-left:60px;
        }
        .Labtitle
        {
            font-family:'Cambria Math';
        }
        .row1
        {
            padding-top:5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-12">
                <h2 class="text-center Labtitle">OPERATIONAL AMPLIFIER DIFFERENTATOR LAB</h2>
            </div>
        </div>
        <div class="row">
            <!--FunctionGenerator-->
            <div class="col-sm-6 ">
                <h4 class="text-center text-info">FUNCTION GENERATOR</h4>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-sm-12">
                                <h6 class="text-center">Amplitude (Vpp)</h6>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <label id="AmplitudeDisplay" class="text-danger  text-xl-right Display">_ _</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <ni:Knob ID="AmplitudeKnob" runat="server" DialColor="Silver" Height="183px" KnobStyle="RaisedWithThinNeedle" Range="0, 20" Width="242px" PointerColor="White"></ni:Knob>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <ni:NumericEdit ID="AmplitudeNumericEdit" Width="100px" runat="server" CssClass="text-sm-right Edit" />
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-sm-12">
                                <h6 class="text-center">Frequency (Hz)</h6>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <label id="FequencyDisplay" class=" text-danger text-xl-right Display">_ _</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <ni:Knob ID="FrequencyKnob" runat="server" DialColor="Silver" Height="183px" KnobStyle="RaisedWithThinNeedle" Range="0, 2000" Width="242px" PointerColor="White"></ni:Knob>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <ni:NumericEdit ID="FrequencyNumericEdit" Width="100px" runat="server" CssClass="text-sm-right Edit" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row row1">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-2">
                        <asp:Button ID="AddDeviceButton" Width="90px" runat="server" Text="AddDev" OnClick="AddDeviceButton_Click" CssClass="btn btn-outline-primary" />
                    </div>
                    <div class="col-sm-6">
                        <asp:DropDownList ID="AvailableDeviceDropDownList" runat="server" />
                    </div>
                </div>
                <div class="row row1">
                    <div class="col-sm-3"></div>
                    <div class="col-sm-1">
                        <asp:Label runat="server" Text="Signal:" />
                    </div>
                    <div class="col-sm-6">
                        <asp:DropDownList ID="SignalDropDownList" runat="server">
                            <asp:ListItem Text="Sine" />
                            <asp:ListItem Text="Square" />
                            <asp:ListItem Text="Triangular" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="row row1">
                    <div class="col-sm-3"></div>
                    <div class="col-sm-5">
                        <asp:Button ID="SetValuesButton" Width="200px" runat="server" CssClass="btn btn-info" Text="Set Values" />
                    </div>
                </div>
            </div>
            <!--Oscilloscope-->
            <div class="col-sm-6">
                <h4 class="text-center text-info">OSCILLOSCOPE</h4>
                <div class="row">
                    <div class="col-sm-10">
                        <ni:WaveformGraph ID="Scope" runat="server" Height="400px" Width="620px" Caption="OpAmp Differentator" Border="Etched" PlotAreaColor="White">
                            <Plots>
                                <ni:WaveformPlot XAxis="XAxes[0]" YAxis="YAxes[0]" LineColor="Red" LineColorPrecedence="UserDefinedColor" />
                                <ni:WaveformPlot LineColor="Blue" LineColorPrecedence="UserDefinedColor" XAxis="XAxes[0]" YAxis="YAxes[0]" />
                            </Plots>
                            <Cursors>
                                <ni:XYCursor Plot="Plots[0]" Color="Red" />
                                <ni:XYCursor Plot="Plots[1]" />
                            </Cursors>
                            <XAxes>
                                <ni:XAxis Caption="Frequency (Hz)" Range="0, 2000" BaseLineVisible="True" MajorDivisions-GridVisible="True" MinorDivisions-GridVisible="True">
                                </ni:XAxis>
                            </XAxes>
                            <YAxes>
                                <ni:YAxis Caption="Amplitude (Vpp)" Range="-10, 10" BaseLineVisible="True" MajorDivisions-GridVisible="True" MinorDivisions-GridVisible="True">
                                </ni:YAxis>
                            </YAxes>
                        </ni:WaveformGraph>
                    </div>
                </div>
                <div class="row row1">
                    <div class="col-sm-3">
                        <asp:Button runat="server" Width="140px" ID="PlotGraphButton" OnClick="PlotGraphButton_Click" CssClass="btn btn-info" Text="Plot Graph"/>
                    </div>
                    <div class="col-sm-3">
                        <asp:Button runat="server" Width="140px" ID="ViewOutputButton" OnClick="ViewOutputButton_Click" CssClass="btn btn-danger" Text="View Output"/>
                    </div>
                    <div class="col-sm-3">
                        <asp:Button runat="server" Width="140px" ID="ViewInputButton" OnClick="ViewInputButton_Click" CssClass="btn btn-primary" Text="View Input"/>
                    </div>
                </div>
            </div>        
        </div>
    </div>
    </form>
    <script src="Content/jquery4.min.js"></script>
    <script src="Content/bootstrap4.min.js"></script>
</body>
</html>
