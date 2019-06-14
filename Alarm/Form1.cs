using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Alarm
{
    public partial class Form1 : Form
    {
        static int MAX = 3;
        int[] hms;

        public Form1()
        {
            InitializeComponent();
            time.Text = "";
            hms = new int[MAX];
            time.Select();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            if(hms[2] > 0)
            {
                hms[2]--;
            }
            else
            {
                if (hms[0]+ hms[1]+ hms[2] == 0)
                {
                    timer1.Stop();
                    timer1.Enabled = false;
                    refresh();
                    MessageBox.Show("끝!", "시간종료", MessageBoxButtons.OK, MessageBoxIcon.Warning, MessageBoxDefaultButton.Button1, MessageBoxOptions.DefaultDesktopOnly);
                    return;
                }

                if (hms[1] > 0) hms[1]--;
                else if (hms[0] > 0)
                {
                    hms[0]--;
                    hms[1] = 59;
                }
                hms[2] = 59;
            }
            tick();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(time.Text)) return;
            else
            {
                int t = Int32.Parse(time.Text);
                hms[0] = t / 60;
                hms[1] = t % 60;
                hms[2] = 0;
                tick();
                time.Text = "";
                timer1.Enabled = true;
                timer1.Start();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            refresh();
        }

        private void time_KeyDown(object sender, KeyEventArgs e)
        {
            Form1_KeyDown(sender, e);
        }

        private void Form1_KeyDown(object sender, KeyEventArgs e)
        {
            try
            {
                if (e.KeyCode == Keys.Enter)
                {
                    button1_Click(sender, e);
                }
                else if (e.KeyCode == Keys.Escape)
                {
                    this.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("catch : " + ex.Message);
            }
        }

        private void stopBtn_KeyDown(object sender, KeyEventArgs e)
        {
            Form1_KeyDown(sender, e);
        }

        private void startBtn_KeyDown(object sender, KeyEventArgs e)
        {
            Form1_KeyDown(sender, e);
        }

        private void tick()
        {
            String []hms_txt = new String[3];
            for(int i = 0; i < MAX; i++)
            {
                if (hms[i] / 10 == 0) hms_txt[i] = "0" + hms[i].ToString();
                else hms_txt[i] = hms[i].ToString();
            }
            count.Text = hms_txt[0] + ":" + hms_txt[1] + ":" + hms_txt[2];
        }

        private void refresh()
        {
            time.Text = "";
            hms[0] = hms[1] = hms[2] = 0;
            count.Text = "00:00:00";
            timer1.Stop();
        }
    }
}
