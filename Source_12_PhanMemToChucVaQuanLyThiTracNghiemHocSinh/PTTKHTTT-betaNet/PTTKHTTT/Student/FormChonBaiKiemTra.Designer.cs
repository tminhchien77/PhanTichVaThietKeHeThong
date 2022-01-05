
namespace PTTKHTTT.Student
{
    partial class FormChonBaiKiemTra
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.SP_ChonBaiKiemTra = new PTTKHTTT.SP_ChonBaiKiemTra();
            this.bdsChonBaiKT = new System.Windows.Forms.BindingSource(this.components);
            this.sP_CHONBAIKIEMTRATableAdapter = new PTTKHTTT.SP_ChonBaiKiemTraTableAdapters.SP_CHONBAIKIEMTRATableAdapter();
            this.tableAdapterManager = new PTTKHTTT.SP_ChonBaiKiemTraTableAdapters.TableAdapterManager();
            this.sP_CHONBAIKIEMTRAGridControl = new DevExpress.XtraGrid.GridControl();
            this.gridView1 = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.colMaMon = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colTenMon = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colTenLoai = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colThoiGianBatDau = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colThoiGianLamBai = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colSoCauJoi = new DevExpress.XtraGrid.Columns.GridColumn();
            this.btnVaoThi = new DevExpress.XtraEditors.SimpleButton();
            this.btnExit = new DevExpress.XtraEditors.SimpleButton();
            ((System.ComponentModel.ISupportInitialize)(this.SP_ChonBaiKiemTra)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bdsChonBaiKT)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.sP_CHONBAIKIEMTRAGridControl)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // SP_ChonBaiKiemTra
            // 
            this.SP_ChonBaiKiemTra.DataSetName = "SP_ChonBaiKiemTra";
            this.SP_ChonBaiKiemTra.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // bdsChonBaiKT
            // 
            this.bdsChonBaiKT.DataMember = "SP_CHONBAIKIEMTRA";
            this.bdsChonBaiKT.DataSource = this.SP_ChonBaiKiemTra;
            // 
            // sP_CHONBAIKIEMTRATableAdapter
            // 
            this.sP_CHONBAIKIEMTRATableAdapter.ClearBeforeFill = true;
            // 
            // tableAdapterManager
            // 
            this.tableAdapterManager.BackupDataSetBeforeUpdate = false;
            this.tableAdapterManager.Connection = null;
            this.tableAdapterManager.UpdateOrder = PTTKHTTT.SP_ChonBaiKiemTraTableAdapters.TableAdapterManager.UpdateOrderOption.InsertUpdateDelete;
            // 
            // sP_CHONBAIKIEMTRAGridControl
            // 
            this.sP_CHONBAIKIEMTRAGridControl.DataSource = this.bdsChonBaiKT;
            this.sP_CHONBAIKIEMTRAGridControl.Dock = System.Windows.Forms.DockStyle.Top;
            this.sP_CHONBAIKIEMTRAGridControl.Location = new System.Drawing.Point(0, 0);
            this.sP_CHONBAIKIEMTRAGridControl.MainView = this.gridView1;
            this.sP_CHONBAIKIEMTRAGridControl.Name = "sP_CHONBAIKIEMTRAGridControl";
            this.sP_CHONBAIKIEMTRAGridControl.Size = new System.Drawing.Size(1193, 220);
            this.sP_CHONBAIKIEMTRAGridControl.TabIndex = 1;
            this.sP_CHONBAIKIEMTRAGridControl.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.gridView1});
            this.sP_CHONBAIKIEMTRAGridControl.Click += new System.EventHandler(this.sP_CHONBAIKIEMTRAGridControl_Click);
            // 
            // gridView1
            // 
            this.gridView1.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.colMaMon,
            this.colTenMon,
            this.colTenLoai,
            this.colThoiGianBatDau,
            this.colThoiGianLamBai,
            this.colSoCauJoi});
            this.gridView1.GridControl = this.sP_CHONBAIKIEMTRAGridControl;
            this.gridView1.Name = "gridView1";
            this.gridView1.OptionsBehavior.Editable = false;
            // 
            // colMaMon
            // 
            this.colMaMon.Caption = "MÃ MÔN";
            this.colMaMon.FieldName = "MaMon";
            this.colMaMon.MinWidth = 25;
            this.colMaMon.Name = "colMaMon";
            this.colMaMon.Visible = true;
            this.colMaMon.VisibleIndex = 0;
            this.colMaMon.Width = 94;
            // 
            // colTenMon
            // 
            this.colTenMon.Caption = "TÊN MÔN";
            this.colTenMon.FieldName = "TenMon";
            this.colTenMon.MinWidth = 25;
            this.colTenMon.Name = "colTenMon";
            this.colTenMon.Visible = true;
            this.colTenMon.VisibleIndex = 1;
            this.colTenMon.Width = 94;
            // 
            // colTenLoai
            // 
            this.colTenLoai.Caption = "LOẠI";
            this.colTenLoai.FieldName = "TenLoai";
            this.colTenLoai.MinWidth = 25;
            this.colTenLoai.Name = "colTenLoai";
            this.colTenLoai.Visible = true;
            this.colTenLoai.VisibleIndex = 2;
            this.colTenLoai.Width = 94;
            // 
            // colThoiGianBatDau
            // 
            this.colThoiGianBatDau.Caption = "THỜI GIAN BẮT ĐẦU";
            this.colThoiGianBatDau.FieldName = "ThoiGianBatDau";
            this.colThoiGianBatDau.MinWidth = 25;
            this.colThoiGianBatDau.Name = "colThoiGianBatDau";
            this.colThoiGianBatDau.Visible = true;
            this.colThoiGianBatDau.VisibleIndex = 3;
            this.colThoiGianBatDau.Width = 94;
            // 
            // colThoiGianLamBai
            // 
            this.colThoiGianLamBai.Caption = "THỜI GIAN LÀM BÀI";
            this.colThoiGianLamBai.FieldName = "ThoiGianLamBai";
            this.colThoiGianLamBai.MinWidth = 25;
            this.colThoiGianLamBai.Name = "colThoiGianLamBai";
            this.colThoiGianLamBai.Visible = true;
            this.colThoiGianLamBai.VisibleIndex = 4;
            this.colThoiGianLamBai.Width = 94;
            // 
            // colSoCauJoi
            // 
            this.colSoCauJoi.Caption = "SỐ CÂU HỎI";
            this.colSoCauJoi.FieldName = "SoCauJoi";
            this.colSoCauJoi.MinWidth = 25;
            this.colSoCauJoi.Name = "colSoCauJoi";
            this.colSoCauJoi.Visible = true;
            this.colSoCauJoi.VisibleIndex = 5;
            this.colSoCauJoi.Width = 94;
            // 
            // btnVaoThi
            // 
            this.btnVaoThi.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.btnVaoThi.Location = new System.Drawing.Point(310, 335);
            this.btnVaoThi.Name = "btnVaoThi";
            this.btnVaoThi.Size = new System.Drawing.Size(209, 80);
            this.btnVaoThi.TabIndex = 3;
            this.btnVaoThi.Text = "VÀO THI";
            this.btnVaoThi.Click += new System.EventHandler(this.btnVaoThi_Click);
            // 
            // btnExit
            // 
            this.btnExit.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.btnExit.Location = new System.Drawing.Point(655, 335);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(209, 80);
            this.btnExit.TabIndex = 4;
            this.btnExit.Text = "THOÁT";
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // FormChonBaiKiemTra
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1193, 550);
            this.Controls.Add(this.btnExit);
            this.Controls.Add(this.btnVaoThi);
            this.Controls.Add(this.sP_CHONBAIKIEMTRAGridControl);
            this.Name = "FormChonBaiKiemTra";
            this.Text = "FormChonBaiKiemTra";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.FormChonBaiKiemTra_Load);
            ((System.ComponentModel.ISupportInitialize)(this.SP_ChonBaiKiemTra)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bdsChonBaiKT)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.sP_CHONBAIKIEMTRAGridControl)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridView1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private SP_ChonBaiKiemTra SP_ChonBaiKiemTra;
        private System.Windows.Forms.BindingSource bdsChonBaiKT;
        private SP_ChonBaiKiemTraTableAdapters.SP_CHONBAIKIEMTRATableAdapter sP_CHONBAIKIEMTRATableAdapter;
        private SP_ChonBaiKiemTraTableAdapters.TableAdapterManager tableAdapterManager;
        private DevExpress.XtraGrid.GridControl sP_CHONBAIKIEMTRAGridControl;
        private DevExpress.XtraGrid.Views.Grid.GridView gridView1;
        private DevExpress.XtraGrid.Columns.GridColumn colTenMon;
        private DevExpress.XtraGrid.Columns.GridColumn colTenLoai;
        private DevExpress.XtraGrid.Columns.GridColumn colThoiGianBatDau;
        private DevExpress.XtraGrid.Columns.GridColumn colThoiGianLamBai;
        private DevExpress.XtraGrid.Columns.GridColumn colSoCauJoi;
        private DevExpress.XtraEditors.SimpleButton btnVaoThi;
        private DevExpress.XtraEditors.SimpleButton btnExit;
        private DevExpress.XtraGrid.Columns.GridColumn colMaMon;
    }
}