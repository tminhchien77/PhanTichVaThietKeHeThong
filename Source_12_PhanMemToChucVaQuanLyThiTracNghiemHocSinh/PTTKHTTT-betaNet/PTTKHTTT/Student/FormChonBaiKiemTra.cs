using DevExpress.XtraEditors;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PTTKHTTT.Student
{
    public partial class FormChonBaiKiemTra : DevExpress.XtraEditors.XtraForm
    {
        public FormChonBaiKiemTra()
        {
            InitializeComponent();
        }

        private void FormChonBaiKiemTra_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'sP_ChonBaiKiemTra.SP_CHONBAIKIEMTRA' table. You can move, or remove it, as needed.
            SP_ChonBaiKiemTra.EnforceConstraints = false;
            this.sP_CHONBAIKIEMTRATableAdapter.Connection.ConnectionString = Program.connStr;
            this.sP_CHONBAIKIEMTRATableAdapter.Fill(this.SP_ChonBaiKiemTra.SP_CHONBAIKIEMTRA);

            bdsChonBaiKT.Filter = "MALOP = '" + Program.maLop + "' and ThoiGianBatDau >= '" + getSqlDate(DateTime.Now) + "' and ThoiGianBatDau < '" + getSqlDate(DateTime.Now.AddDays(1)) + "'";
        }

        private String getSqlDate(DateTime date)
        {
            String year = "" + date.Year;
            String month = (date.Month < 10) ? "0" + date.Month : "" + date.Month;
            String day = (date.Day < 10) ? "0" + date.Day : "" + date.Day;
            return year + "-" + month + "-" + day + " 00:00:00";
        }

        private void btnVaoThi_Click(object sender, EventArgs e)
        {
            if (bdsChonBaiKT.Count == 0)
            {
                MessageBox.Show("Không có lịch thi", "Thông báo", MessageBoxButtons.OK);
                return;
            }
            FormKiemTra.thoiGianLamBai = Int32.Parse(((DataRowView)bdsChonBaiKT[bdsChonBaiKT.Position])["ThoiGianLamBai"].ToString());
            FormKiemTra.maDangKy = Int32.Parse(((DataRowView)bdsChonBaiKT[bdsChonBaiKT.Position])["maDangKy"].ToString());

            string strCHECKDAKIEMTRACHUA = "EXEC SP_CHECKDAKIEMTRACHUA '" + Program.userName + "','" + FormKiemTra.maDangKy + "'";
            if (Program.execNonQuery(strCHECKDAKIEMTRACHUA) != 0)
                return;

            Student.FormKiemTra frmThi = new FormKiemTra();
            frmThi.Activate();
            frmThi.Show();
            this.Hide();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void sP_CHONBAIKIEMTRAGridControl_Click(object sender, EventArgs e)
        {

        }
    }
}