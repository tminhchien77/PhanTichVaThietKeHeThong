using DevExpress.XtraEditors;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PTTKHTTT.Teacher
{
    public partial class UCRegisExam : DevExpress.XtraEditors.XtraUserControl
    {
        private static UCRegisExam _instance;
        private int _grade;
        private BindingSource bindingSourceTreeLessons;
        private int idSub;
        public static UCRegisExam Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new UCRegisExam();
                return _instance;
            }
        }
        public UCRegisExam()
        {
            InitializeComponent();
            dateEditExamDate.Properties.MinValue = DateTime.Today;
        }


        private void UCRegisExam_Load(object sender, EventArgs e)
        {

            childContainer.Controls.Add(sP_GetAllSubOfGrade_TeacherGridControl);
            sP_GetAllSubOfGrade_TeacherGridControl.BringToFront();
            sP_GetAllSubOfGrade_TeacherGridControl.Dock = DockStyle.Fill;
            try
            {
                this.sP_GetAllSubOfGrade_TeacherTableAdapter1.Fill(this.kiemTraHSDataSet.SP_GetAllSubOfGrade_Teacher, Program.userName);
            }
            catch (System.Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message);
            }
            /*(DataRowView)(tileView1.GetRow(0)).*/
        }

        private void tileView1_FocusedRowChanged(object sender, DevExpress.XtraGrid.Views.Base.FocusedRowChangedEventArgs e)
        {
            
            
            
        }

        private void loadGridViewClasses(int idSub)
        {
            try
            {
                this.sP_GetAllClassBy_Sub_Grade_TeacherTableAdapter.Fill(this.kiemTraHSDataSet._SP_GetAllClassBy_Sub_Grade_Teacher, Program.userName, idSub);
            }
            catch (System.Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message);
            }
            int i = gridViewClasses.RowCount;
        }

        private void loadComboboxExamType()
        {
            DataTable dt = new DataTable();
            String str = "EXEC SP_GetExamTypes";
            try
            {
                dt = Program.execSqlDataTable(str);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi tải câu hỏi\n" + ex.Message, "Thông báo", MessageBoxButtons.OK);
                return;
            }
            lookUpExamTypes.Properties.DataSource = dt;
            lookUpExamTypes.Properties.PopulateColumns();
            lookUpExamTypes.Properties.Columns[0].Visible = false;
            lookUpExamTypes.Properties.DisplayMember = "TenLoai";
        }

        private void loadTreeViewLessons()
        {
            string classes = "";
            for (int i = 0; i < gridViewClasses.RowCount; i++)
            {
                DataRowView row = gridViewClasses.GetRow(i) as DataRowView;
                if (row != null)
                {
                    classes += row["MaLop"] + ",";
                }
            }
            foreach (TreeNode node in treeViewLessons.Nodes)
            {
                node.Nodes.Clear();
            }
            

            DataTable dt = new DataTable();
            String str = "EXEC SP_GetAllLessonToRegis " + idSub + ",'" + classes + "'";
            try
            {
                dt = Program.execSqlDataTable(str);

            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi tải câu hỏi\n" + ex.Message, "Thông báo", MessageBoxButtons.OK);
                return;
            }
            /*            foreach (DataRow dr in dt.Rows)
            */
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                foreach (TreeNode parentNode in treeViewLessons.Nodes)
                {
                    if (dt.Rows[i]["HocKy"].ToString().CompareTo(parentNode.Text) == 0)
                    {
                        TreeNode node = new TreeNode((string)dt.Rows[i]["TenBai"]);
                        node.Tag = dt.Rows[i]["MaBaiHoc"];
                        parentNode.Nodes.Add(node);

                    }
                }
            }
        }

        private void treeListLookUpEdit2_EditValueChanged(object sender, EventArgs e)
        {

        }

        private void lookUpExamTypes_EditValueChanged(object sender, EventArgs e)
        {
            LookUpEdit lookUp = sender as LookUpEdit;
            // Access the currently selected data row
            DataRowView dataRow = lookUp.GetSelectedDataRow() as DataRowView;
            if (dataRow != null)
            {
                spinTimeExam.EditValue = dataRow["ThoiGianLamBai"];
            }
        }

        private void btnRegis_Click(object sender, EventArgs e)
        {
            

            int idExamType = 0;
            DateTime examTimeStart;
            int examTime=0;
            string idClasses = "";
            int numQues = 0;
            string idLessons = "";
            DataRowView dataRow = lookUpExamTypes.GetSelectedDataRow() as DataRowView;
            if (dataRow != null)
            {
                idExamType = (int)dataRow["MaLoai"];
            }
            else
            {
                MessageBox.Show("Loại bài kiểm tra không được để trống!", "Thông báo", MessageBoxButtons.OK);
                lookUpExamTypes.Focus();
                return;
            }
            examTimeStart = dateEditExamDate.DateTime.Date.Add(timeEditExamTime.Time.TimeOfDay);
            if (examTimeStart < DateTime.Now)
            {
                MessageBox.Show("Thời điểm bắt đầu làm bài không hợp lệ!", "Thông báo", MessageBoxButtons.OK);
                timeEditExamTime.Focus();
                return;
            }

            if (numQuesSpinEdit.Value <= 0)
            {
                MessageBox.Show("Số lượng câu hỏi là một số lớn hơn 0!", "Thông báo", MessageBoxButtons.OK);
                numQuesSpinEdit.Focus();
                return;
            }
            else numQues = (int)numQuesSpinEdit.Value;

            if (spinTimeExam.Value > 0)
            {
                examTime = (int)spinTimeExam.Value;
            }
            else
            {
                MessageBox.Show("Thời gian làm bài là một số lớn hơn 0!", "Thông báo", MessageBoxButtons.OK);
                spinTimeExam.Focus();
                return;
            }

            int[] selectedRows = gridViewClasses.GetSelectedRows();
            if (selectedRows.Length == 0)
            {
                MessageBox.Show("Vui lòng chọn các lớp kiểm tra!", "Thông báo", MessageBoxButtons.OK);
                gridControlClasses.Focus();
                return;
            }
            else
            {
                for (int i = 0; i < selectedRows.Length; i++)
                {
                    int id = (int)gridViewClasses.GetRowCellValue(selectedRows[i], "MaLop");
                    idClasses += id + ",";
                }
            }

            foreach (TreeNode parentNode in treeViewLessons.Nodes)
            {
                foreach(TreeNode childNode in parentNode.Nodes)
                {
                    if (childNode.Checked)
                    {
                        idLessons += childNode.Tag + ",";
                    }
                }
                //The main parent node does not have a parent
                
            }
            if (idLessons.Length == 0)
            {
                MessageBox.Show("Vui lòng chọn danh sách bài học kiểm tra!", "Thông báo", MessageBoxButtons.OK);
                return;
            }

            int isEnough = 0;

            DataTable dtCheckEnoughQues = new DataTable();
            String strCheckEnoughQues = "EXEC SP_CheckEnoughQues '" + idLessons + "'," + numQues;
            try
            {
                dtCheckEnoughQues = Program.execSqlDataTable(strCheckEnoughQues);
                isEnough = (int)dtCheckEnoughQues.Rows[0]["result"];

            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi kiểm tra đăng ký\n"+ex.Message, "Thông báo", MessageBoxButtons.OK);
                return;
            }

            if (isEnough == 0)
            {
                MessageBox.Show("Không đủ số lượng câu hỏi yêu cầu!", "Thông báo", MessageBoxButtons.OK);
                return;
            }

            string formatDatetime = "yyyy-MM-dd HH:mm:ss";
            String str = "EXEC SP_RegisExam " + idExamType+ ", " + numQues+ ",'" + examTimeStart.ToString(formatDatetime) + "', "+ examTime+ ", '"+ idClasses+"', '"+ idLessons+"'";
            try
            {
                Program.execNonQuery(str);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi thêm đăng ký\n" + ex.Message, "Thông báo", MessageBoxButtons.OK);
                return;
            }

            MessageBox.Show("Thành công!", "Thông báo", MessageBoxButtons.OK);
            loadGridViewClasses(idSub);
            loadTreeViewLessons();

        }

        private void treeViewLessons_AfterCheck(object sender, TreeViewEventArgs e)
        {
            if (e.Node.Parent == null)
            {
                if (e.Node.Checked)
                {
                    foreach (TreeNode node in e.Node.Nodes)
                    {
                        node.Checked = true;
                    }
                }
                else
                {
                    int countCheckedNode = 0;
                    foreach (TreeNode node in e.Node.Nodes)
                    {
                        if (node.Checked) countCheckedNode++;
                        else break;
                    }
                    if (countCheckedNode == e.Node.Nodes.Count)
                    {
                        foreach (TreeNode node in e.Node.Nodes)
                        {
                            node.Checked = false;
                        }
                    }
                }
            }
            else if(e.Node.Parent != null && !e.Node.Checked && e.Node.Parent.Checked)
            {
                e.Node.Parent.Checked = false;
            }
        }

        private void exitBtn_Click(object sender, EventArgs e)
        {
            childContainer.Controls.Add(sP_GetAllSubOfGrade_TeacherGridControl);
            sP_GetAllSubOfGrade_TeacherGridControl.BringToFront();
            sP_GetAllSubOfGrade_TeacherGridControl.Dock = DockStyle.Fill;
        }

        private void subsTileView_Click(object sender, EventArgs e)
        {
            childContainer.Controls.Add(regisForm);
            regisForm.BringToFront();
            regisForm.Dock = DockStyle.Fill;
            int index = subsTileView.GetSelectedRows().FirstOrDefault();
            DataRowView selRow = (DataRowView)(subsTileView.GetRow(index));
            idSub = (int)selRow["MaMon"];

            loadComboboxExamType();
            loadGridViewClasses(idSub);
            
            
        }

        private void gridViewClasses_AfterPrintRow(object sender, DevExpress.XtraGrid.Views.Printing.PrintRowEventArgs e)
        {
            string classes = "";
            for (int i = 0; i < gridViewClasses.RowCount; i++)
            {
                DataRowView row = gridViewClasses.GetRow(i) as DataRowView;
                if (row != null)
                {
                    classes += row["MaLop"] + ",";
                }
            }
        }

        private void gridViewClasses_BeforePrintRow(object sender, DevExpress.XtraGrid.Views.Printing.CancelPrintRowEventArgs e)
        {

        }

        private void gridViewClasses_AsyncCompleted(object sender, EventArgs e)
        {

        }

        private void gridViewClasses_RowCountChanged(object sender, EventArgs e)
        {
            loadTreeViewLessons();
        }

        private void gridViewClasses_CustomDrawRowIndicator(object sender, DevExpress.XtraGrid.Views.Grid.RowIndicatorCustomDrawEventArgs e)
        {
            if (e.RowHandle >= 0)
                e.Info.DisplayText = (e.RowHandle+1).ToString();
        }
    }
}
