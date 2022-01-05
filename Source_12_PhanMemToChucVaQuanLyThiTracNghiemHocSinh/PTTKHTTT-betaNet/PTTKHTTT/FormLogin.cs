using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace PTTKHTTT
{
    public partial class FormLogin : DevExpress.XtraEditors.XtraForm
    {
        public FormLogin()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            if(txtUserName.Text.Trim() == "" || txtPassword.Text.Trim() == "")
            {
                MessageBox.Show("Tài khoản không được để trống", "Thông báo", MessageBoxButtons.OK);
                txtUserName.Focus();
                return;
            }
            try
            {
                if (Program.connection() == 0) return;
                Program.userName = txtUserName.Text;
                Program.password = txtPassword.Text;
                String hashPash = EncryptPassword.myEncrypt(Program.password);
                if (rdbTeacher.Checked)
                {
                    String strCHECKTAIKHOANGIAOVIEN = "EXEC SP_CheckAccountTeacher '" + Program.userName + "','" + hashPash + "'";
                    if (Program.execNonQuery(strCHECKTAIKHOANGIAOVIEN) == 1) return;

                    String strGetInfoTeacher = "EXEC SP_GetInfoTeacher '" + Program.userName + "'";
                    Program.myReader = Program.execSqlDataReader(strGetInfoTeacher);
                    if (Program.myReader == null) return;
                    Program.myReader.Read();
                    Program.hoten = Program.myReader.GetString(0);

                    Teacher.FormTeacher frmTeacher = new Teacher.FormTeacher();
                    frmTeacher.Activate();
                    frmTeacher.Show();
                    this.Hide();

                    Program.myReader.Close();
                }
                else if (rdbStudent.Checked)
                {
                    String strCHECKTAIKHOANHOCSINH = "EXEC SP_CHECKTAIKHOANHOCSINH '" + Program.userName + "','" + hashPash + "'";
                    if (Program.execNonQuery(strCHECKTAIKHOANHOCSINH) == 1) return;
                    String strGETINTOSTUDENT = "EXEC SP_GETINFOSTUDENT '" + Program.userName + "'";
                    Program.myReader = Program.execSqlDataReader(strGETINTOSTUDENT);
                    if (Program.myReader == null) return;
                    Program.myReader.Read();
                    Program.hoten = Program.myReader.GetString(0);
                    Program.maLop = Program.myReader.GetInt32(1);
                    Program.tenLop = Program.myReader.GetString(2);
                    
                    Student.FormChonBaiKiemTra frmChonBaiKiemTra = new Student.FormChonBaiKiemTra();
                    frmChonBaiKiemTra.Activate();
                    frmChonBaiKiemTra.Show();
                    this.Hide();

                    Program.myReader.Close();
                }
                else
                {
                    if(Program.userName.CompareTo("ADMIN")==0 && Program.password.CompareTo("admin") == 0)
                    {
                        Admin.FormAdmin frmAdmin = new Admin.FormAdmin();
                        frmAdmin.Activate();
                        frmAdmin.Show();
                        this.Hide();
                    }
                    else
                    {
                        MessageBox.Show("Tên đăng nhập hoặc mật khẩu không chính xác", "Thông báo", MessageBoxButtons.OK);
                        txtUserName.Focus();
                        return;
                    }
                    /*String strCHECKTAIKHOANGIAOVIEN = "EXEC SP_CheckAccountTeacher '" + Program.userName + "','" + hashPash + "'";
                    if (Program.execNonQuery(strCHECKTAIKHOANGIAOVIEN) == 1) return;

                    String strGetInfoTeacher = "EXEC SP_GetInfoTeacher '" + Program.userName + "'";
                    Program.myReader = Program.execSqlDataReader(strGetInfoTeacher);
                    if (Program.myReader == null) return;
                    Program.myReader.Read();
                    Program.hoten = Program.myReader.GetString(0);

                    Teacher.FormTeacher frmTeacher = new Teacher.FormTeacher();
                    frmTeacher.Activate();
                    frmTeacher.Show();
                    this.Hide();

                    Program.myReader.Close();*/
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Thông báo", MessageBoxButtons.OK);
                return;
            }
        }
    }
}
