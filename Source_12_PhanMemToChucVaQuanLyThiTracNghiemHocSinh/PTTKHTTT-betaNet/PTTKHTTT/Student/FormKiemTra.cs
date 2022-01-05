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
using DevExpress.XtraEditors.Controls;

namespace PTTKHTTT.Student
{
    public partial class FormKiemTra : DevExpress.XtraEditors.XtraForm
    {
        public static int thoiGianLamBai = 0;
        public static int maDangKy = -1;

        private static int second = 0;
        private static int minute = 0;

        Dictionary<int, DeKiemTra> dictionary = new Dictionary<int, DeKiemTra>();
        BindingSource bdsDeKiemTra;
        public FormKiemTra()
        {
            InitializeComponent();
        }

        private void barButtonItem2_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            Application.Exit();
        }

        private void FormThi_Load(object sender, EventArgs e)
        {
            minute = thoiGianLamBai - 1;
            second = 60;
            DataTable dt = new DataTable();
            String str = "EXEC SP_GETEXAM '" + maDangKy + "','" + Program.userName + "'";
            try
            {
                dt = Program.execSqlDataTable(str);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi tải câu hỏi\n" + ex.Message, "Thông báo", MessageBoxButtons.OK);
                return;
            }
            bdsDeKiemTra = new BindingSource();
            bdsDeKiemTra.DataSource = dt;
            for(int i = 0; i < bdsDeKiemTra.Count; i++)
            {
                rdbCauSo.Properties.Items.Add(new RadioGroupItem(i + 1, "" + (i + 1)));
                dictionary.Add(i + 1, getDeKiemTraFromBDS(i));
            }
            btnThoat.Enabled = false;
            tabControlMain.TabPages.Remove(tabPageKetQua);
            rdbCauSo.SelectedIndex = 0;
        }

        private DeKiemTra getDeKiemTraFromBDS(int pos)
        {
            DeKiemTra dkt = new DeKiemTra();
            dkt.NoiDung = ((DataRowView)bdsDeKiemTra[pos])["NOIDUNG"].ToString();
            dkt.A = ((DataRowView)bdsDeKiemTra[pos])["A"].ToString();
            dkt.B = ((DataRowView)bdsDeKiemTra[pos])["B"].ToString();
            dkt.C = ((DataRowView)bdsDeKiemTra[pos])["C"].ToString();
            dkt.D = ((DataRowView)bdsDeKiemTra[pos])["D"].ToString();
            dkt.DaChon = "-";
            return dkt;
        }

        private void rdbCauSo_SelectedIndexChanged(object sender, EventArgs e)
        {
            rdbLuaChon.Properties.Items.Clear();
            txtCauHoi.Text = "Câu " + (rdbCauSo.SelectedIndex + 1) + ": " + dictionary[rdbCauSo.SelectedIndex + 1].NoiDung;
            rdbLuaChon.Properties.Items.Add(new RadioGroupItem("A", "A. " + dictionary[rdbCauSo.SelectedIndex + 1].A));
            rdbLuaChon.Properties.Items.Add(new RadioGroupItem("B", "B. " + dictionary[rdbCauSo.SelectedIndex + 1].B));
            rdbLuaChon.Properties.Items.Add(new RadioGroupItem("C", "C. " + dictionary[rdbCauSo.SelectedIndex + 1].C));
            rdbLuaChon.Properties.Items.Add(new RadioGroupItem("D", "D. " + dictionary[rdbCauSo.SelectedIndex + 1].D));
            switch(dictionary[rdbCauSo.SelectedIndex + 1].DaChon)
            {
                case "A":
                    rdbLuaChon.SelectedIndex = 0;
                    break;
                case "B":
                    rdbLuaChon.SelectedIndex = 1;
                    break;
                case "C":
                    rdbLuaChon.SelectedIndex = 2;
                    break;
                case "D":
                    rdbLuaChon.SelectedIndex = 3;
                    break;
                default:
                    rdbLuaChon.SelectedIndex = -1;
                    break;

            }
          
        }

        private void rdbLuaChon_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(rdbLuaChon.SelectedIndex != -1)
            {
                dictionary[rdbCauSo.SelectedIndex + 1].DaChon = rdbLuaChon.EditValue.ToString();
                rdbCauSo.Properties.Items.Clear();
                for (int i = 0; i < bdsDeKiemTra.Count; i++)
                {
                    if(dictionary[i + 1].DaChon == "-")
                    {
                        rdbCauSo.Properties.Items.Add(new RadioGroupItem(i + 1, "" + (i + 1)));
                    } else
                    {
                        rdbCauSo.Properties.Items.Add(new RadioGroupItem(i + 1, "" + (i + 1) + "\ud83c\udf39"));
                    }
                    
                }
            }
        }

        private void timer_Tick(object sender, EventArgs e)
        {
            second--;
            if (second == 0 && minute != 0)
            {
                minute--;
                second = 59;
            }
            if (second == 0 && minute == 0)
            {
                timer.Stop();
                insertDIEMandANSWER();
                navButton();
            }
            showTime();
        }

        private void showTime()
        {
            if (minute < 10)
            {
                if (second < 10)
                {
                    lbTime.Text = "0" + minute + ":0" + second;
                }
                else
                {
                    lbTime.Text = "0" + minute + ":" + second;
                }
            }
            else
            {
                if (second < 10)
                {
                    lbTime.Text = minute + ":0" + second;
                }
                else
                {
                    lbTime.Text = minute + ":" + second;
                }
            }
        }
        private void navButton()
        {
            tabControlMain.TabPages.Add(tabPageKetQua);
            tabControlMain.TabPages.Remove(tabPageThi);
            btnThoat.Enabled = true;
            btnNopBai.Enabled = false;
        }

        private void btnNopBai_ItemClick(object sender, DevExpress.XtraBars.ItemClickEventArgs e)
        {
            if(checkFullDA())
            {
                insertDIEMandANSWER();
                navButton();
                timer.Stop();
            } else
            {
                if (MessageBox.Show("Bạn chưa chọn hết đáp án, bạn chắc chắn muốn nộp bài không?", "Thông báo", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    insertDIEMandANSWER();
                    navButton();
                    timer.Stop();
                }
            }
        }

        private Boolean checkFullDA()
        {
            foreach(KeyValuePair<int, DeKiemTra> item in dictionary)
            {
                if(item.Value.DaChon.Equals("-"))
                {
                    return false;
                }
            }
            return true;
        }

        private void labelControl3_Click(object sender, EventArgs e)
        {

        }
            
        private void insertDIEMandANSWER()
        {
            String ans = "";
            foreach(KeyValuePair<int, DeKiemTra> item in dictionary)
            {
                ans += item.Value.DaChon;
            }
            String strSore = "EXEC SP_SCORE '" + maDangKy + "','" + Program.userName + "','" + ans + "'";
            if (Program.execNonQuery(strSore) != 0) return;
            String strGetScore = "SELECT DBO.GETSCORE('" + Program.userName + "','" + maDangKy + "')";
            Program.myReader = Program.execSqlDataReader(strGetScore);
            if (Program.myReader == null) return;
            Program.myReader.Read();
            lbDiemThi.Text = Program.myReader.GetDouble(0).ToString();
            Program.myReader.Close();
        }

  
    }
}