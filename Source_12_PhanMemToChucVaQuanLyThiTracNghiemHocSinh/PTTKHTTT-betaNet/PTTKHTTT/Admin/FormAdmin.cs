using DevExpress.XtraBars;
using PTTKHTTT.Teacher;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace PTTKHTTT.Admin
{
    public partial class FormAdmin : DevExpress.XtraBars.FluentDesignSystem.FluentDesignForm
    {
        public String idUser = "GV21-001";
        public FormAdmin()
        {
            InitializeComponent();
            nameLbl.Text = Program.hoten;
            idLbl.Text = Program.userName;
        }

        private void accordionControlRegisExam_Click(object sender, EventArgs e)
        {
            if (!mainContainer.Controls.Contains(UCRegisExamAdmin.Instance))
            {
                mainContainer.Controls.Add(UCRegisExamAdmin.Instance);
                UCRegisExamAdmin.Instance.Dock = DockStyle.Fill;
                UCRegisExamAdmin.Instance.BringToFront();
            }
            else
                UCRegisExamAdmin.Instance.BringToFront();
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
            if (!mainContainer.Controls.Contains(UCExamDetailsAdmin.Instance))
            {
                mainContainer.Controls.Add(UCExamDetailsAdmin.Instance);
                UCExamDetailsAdmin.Instance.Dock = DockStyle.Fill;
                UCExamDetailsAdmin.Instance.BringToFront();
            }
            else
                UCExamDetailsAdmin.Instance.BringToFront();
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
