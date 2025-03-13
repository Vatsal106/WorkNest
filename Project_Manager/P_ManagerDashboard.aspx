<%@ Page Title="" Language="C#" MasterPageFile="~/Project_Manager/P_Manager.Master" AutoEventWireup="true" CodeBehind="P_ManagerDashboard.aspx.cs" Inherits="WorkNest.Project_Manager.P_ManagerDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Manager_Head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        var workTimer, breakTimer;
        var workSeconds = sessionStorage.getItem("workSeconds") ? parseInt(sessionStorage.getItem("workSeconds")) : 0;
        var breakSeconds = sessionStorage.getItem("breakSeconds") ? parseInt(sessionStorage.getItem("breakSeconds")) : 0;

        document.addEventListener("DOMContentLoaded", function () {
            if (workSeconds > 0) {
                document.getElementById("<%= lblClockInTime.ClientID %>").innerText = formatTime(workSeconds);
    }
    if (breakSeconds > 0) {
        document.getElementById("<%= lblBreakTime.ClientID %>").innerText = formatTime(breakSeconds);
    }
});

function startWorkTimer() {
    clearInterval(workTimer);
    workTimer = setInterval(function () {
        workSeconds++;
        sessionStorage.setItem("workSeconds", workSeconds);
        document.getElementById("<%= lblClockInTime.ClientID %>").innerText = formatTime(workSeconds);
    }, 1000);
}

function stopWorkTimer() {
    clearInterval(workTimer);
}

function startBreakTimer() {
    clearInterval(breakTimer);
    breakTimer = setInterval(function () {
        breakSeconds++;
        sessionStorage.setItem("breakSeconds", breakSeconds);
        document.getElementById("<%= lblBreakTime.ClientID %>").innerText = formatTime(breakSeconds);
    }, 1000);
        }

        function stopBreakTimer() {
            clearInterval(breakTimer);
        }

        function formatTime(seconds) {
            let hrs = Math.floor(seconds / 3600);
            let mins = Math.floor((seconds % 3600) / 60);
            let secs = seconds % 60;
            return (hrs < 10 ? "0" + hrs : hrs) + ":" +
                (mins < 10 ? "0" + mins : mins) + ":" +
                (secs < 10 ? "0" + secs : secs);
        }
        function resetTimers() {
            clearInterval(workTimer);
            clearInterval(breakTimer);

            workSeconds = 0;
            breakSeconds = 0;

            sessionStorage.setItem("workSeconds", workSeconds);
            sessionStorage.setItem("breakSeconds", breakSeconds);

            document.getElementById("<%= lblClockInTime.ClientID %>").innerText = "00:00:00";
            document.getElementById("<%= lblBreakTime.ClientID %>").innerText = "00:00:00";


        }
        function loadChart(chartData) {
            let ctx = document.getElementById('timelogChart').getContext('2d');

            let labels = chartData.map(item => item.LogDate); 

            let workHours = chartData.map(item => Math.round(item.TotalWorkHours));
            let breakHours = chartData.map(item => Math.round(item.TotalBreakHours));

            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: "Work Hours",
                            data: workHours,
                            backgroundColor: 'rgba(54, 162, 235, 0.6)',
                            borderWidth: 0
                        },
                        {
                            label: "Break Hours",
                            data: breakHours,
                            backgroundColor: 'rgba(255, 99, 132, 0.6)',
                            borderWidth: 0
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                display: false 
                            },
                            ticks: {
                                stepSize: 1 ,
                                 padding: 15
                            },
                            title: {
                                display: true,
                                text: 'Hours',
                                padding: {
                                    top: 10, 
                                    bottom: 10 
                                }
                            }
                        },
                        x: {
                            grid: {
                                display: false 
                            },
                            title: {
                                display: true,
                                text: 'Days',
                                padding: {
                                    top: 10,
                                    bottom: 10 
                                }
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            position: 'top',
                            labels: {
                                padding: 20 
                            }
                        }
                    }
                }
            });
        }
    </script>
    <style>
        #timelogChart {
    max-height: 450px !important; 
    max-width: 100%;
}
        .time-tracker {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.profile-circle {
    width: 60px;
    height: 60px;
    background: #007bff;
    color: #fff;
    font-size: 24px;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    margin: auto;
}

.timing-box {
    background: #f8f9fa;
    padding: 10px;
    border-radius: 5px;
}

.time-label {
    font-size: 18px;
    font-weight: bold;
    display: block;
}

.btn {
    border-radius: 5px;
}
.custom-calendar {
    width: 100%;
    border-collapse: collapse;
    font-family: Arial, sans-serif;
}

.custom-calendar td {
    width: 40px;
    height: 40px;
    text-align: center;
    font-size: 14px;
    position: relative;
}

.present-dot, .absent-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    position: absolute;
    bottom: 5px;
    left: 50%;
    transform: translateX(-50%);
}


.present-dot {
    background-color: #4CAF50;
}


.absent-dot {
    background-color: #F44336;
}
/*.custom-calendar a {
    text-decoration: none !important;
    color: inherit !important; 
    cursor: default; 
    pointer-events: none; 
}*/

        </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Manager_Header_Title" runat="server">
    <div class="Manager_Header_Title text-center">Dashboard</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Manager_Content" runat="server">
    <div class="container mt-4">
        <div class="row">
            <div class="col-lg-8">
                <div class="card p-3">
                    <h4>Notice Board (0)</h4>
                    <div class="text-center">
                        <img src="your-notice-image.png" alt="No Notice" class="img-fluid" style="max-width: 150px;">
                        <p>No Notice Found</p>
                    </div>
                </div>

                <div class="card p-3 mt-4">
                    <h4>My Timelogs - Last 7 Days</h4>
                    <canvas id="timelogChart" width="500" height="400"></canvas>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card p-3 time-tracker">
                    <div class="text-center">
    <div class="profile-circle">
        <asp:Label ID="lblInitials" runat="server"></asp:Label>
    </div>
    <h5>
        <asp:Label ID="lblEmployeeName" runat="server" Text="Loading..." />
    </h5>
    <p class="text-muted">
        <asp:Label ID="lblEmployeeRole" runat="server" Text="Loading..." />
    </p>
</div>


                    <h6 class="mt-3">My Timing</h6>
                    <div class="timing-box d-flex justify-content-between">
                        <div>
                            <span>Current Time</span>
                            <asp:Label ID="lblClockInTime" runat="server" Text="00:00:00" CssClass="time-label"></asp:Label>
                        </div>
                        <div>
                            <span>Break Time</span>
                            <asp:Label ID="lblBreakTime" runat="server" Text="00:00:00" CssClass="time-label text-danger"></asp:Label>
                        </div>
                    </div>

                    <div class="mt-3 text-center">
                        <asp:Button ID="btnClockIn" runat="server" CssClass="btn btn-success w-100" Text="Clock In" OnClick="btnClockIn_Click" />
                        <asp:Button ID="btnBreakTime" runat="server" CssClass="btn btn-warning w-100 mt-2 d-none" Text="Break Time" OnClick="btnBreakTime_Click" />
                        <asp:Button ID="btnStopBreak" runat="server" CssClass="btn btn-danger w-100 mt-2 d-none" Text="Stop Break" OnClick="btnStopBreak_Click" />
                        <asp:Button ID="btnClockOut" runat="server" CssClass="btn btn-danger w-100 mt-2 d-none" Text="Clock Out" OnClick="btnClockOut_Click" />
                    </div>
                </div>

              <div class="card p-3 mt-4">
    <h6>Attendance Calendar</h6>
    <asp:Calendar ID="AttendanceCalendar" runat="server" 
        OnVisibleMonthChanged="AttendanceCalendar_VisibleMonthChanged" 
    OnDayRender="AttendanceCalendar_DayRender" 
    CssClass="custom-calendar">
</asp:Calendar>
</div>
            </div>
        </div>
    </div>
</asp:Content>
