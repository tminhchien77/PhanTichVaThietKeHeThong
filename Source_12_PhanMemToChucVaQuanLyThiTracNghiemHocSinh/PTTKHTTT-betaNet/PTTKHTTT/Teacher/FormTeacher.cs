using DevExpress.XtraBars;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace PTTKHTTT.Teacher
{
    public partial class FormTeacher : DevExpress.XtraBars.FluentDesignSystem.FluentDesignForm
    {
        public String idUser = "GV21-001";
        public FormTeacher()
        {
            InitializeComponent();
            nameLbl.Text = Program.hoten;
            idLbl.Text = Program.userName;
        }

        private void accordionControlRegisExam_Click(object sender, EventArgs e)
        {
            if (!mainContainer.Controls.Contains(UCRegisExam.Instance))
            {
                mainContainer.Controls.Add(UCRegisExam.Instance);
                UCRegisExam.Instance.Dock = DockStyle.Fill;
                UCRegisExam.Instance.BringToFront();
            }
            else
                UCRegisExam.Instance.BringToFront();
        }

        private void accordionControlQues_Click(object sender, EventArgs e)
        {
            if (!mainContainer.Controls.Contains(UCQues.Instance))
            {
                mainContainer.Controls.Add(UCQues.Instance);
                UCQues.Instance.Dock = DockStyle.Fill;
                UCQues.Instance.BringToFront();
            }
            else
                UCQues.Instance.BringToFront();
        }

        private void accordionControlExamDetails_Click(object sender, EventArgs e)
        {
            if (!mainContainer.Controls.Contains(UCExamDetails.Instance))
            {
                mainContainer.Controls.Add(UCExamDetails.Instance);
                UCExamDetails.Instance.Dock = DockStyle.Fill;
                UCExamDetails.Instance.BringToFront();
            }
            else
                UCExamDetails.Instance.BringToFront();
        }

        private void logoutBtn_Click(object sender, EventArgs e)
        {
            this.Hide();
            FormLogin loginForm = new FormLogin();
            loginForm.Activate();
            loginForm.Show();
        }
    }
}
