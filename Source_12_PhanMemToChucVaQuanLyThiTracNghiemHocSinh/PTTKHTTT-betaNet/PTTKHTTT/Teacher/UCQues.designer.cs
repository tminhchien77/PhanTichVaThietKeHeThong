
namespace PTTKHTTT.Teacher
{
    partial class UCQues
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.Label noiDungLabel;
            System.Windows.Forms.Label aLabel;
            System.Windows.Forms.Label bLabel;
            System.Windows.Forms.Label cLabel;
            System.Windows.Forms.Label dLabel;
            System.Windows.Forms.Label dapAnLabel;
            System.Windows.Forms.Label trangThaiLabel;
            DevExpress.XtraEditors.TableLayout.TableColumnDefinition tableColumnDefinition1 = new DevExpress.XtraEditors.TableLayout.TableColumnDefinition();
            DevExpress.XtraEditors.TableLayout.TableColumnDefinition tableColumnDefinition2 = new DevExpress.XtraEditors.TableLayout.TableColumnDefinition();
            DevExpress.XtraEditors.TableLayout.TableColumnDefinition tableColumnDefinition3 = new DevExpress.XtraEditors.TableLayout.TableColumnDefinition();
            DevExpress.XtraEditors.TableLayout.TableRowDefinition tableRowDefinition1 = new DevExpress.XtraEditors.TableLayout.TableRowDefinition();
            DevExpress.XtraEditors.TableLayout.TableRowDefinition tableRowDefinition2 = new DevExpress.XtraEditors.TableLayout.TableRowDefinition();
            DevExpress.XtraEditors.TableLayout.TableRowDefinition tableRowDefinition3 = new DevExpress.XtraEditors.TableLayout.TableRowDefinition();
            DevExpress.XtraGrid.Views.Tile.TileViewItemElement tileViewItemElement1 = new DevExpress.XtraGrid.Views.Tile.TileViewItemElement();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(UCQues));
            System.Windows.Forms.TreeNode treeNode1 = new System.Windows.Forms.TreeNode("Học kỳ 1");
            System.Windows.Forms.TreeNode treeNode2 = new System.Windows.Forms.TreeNode("Học kỳ 2");
            this.colTenMon1 = new DevExpress.XtraGrid.Columns.TileViewColumn();
            this.repositoryItemCheckEdit1 = new DevExpress.XtraEditors.Repository.RepositoryItemCheckEdit();
            this.sP_GetAllSubOfGrade_TeacherGridControl = new DevExpress.XtraGrid.GridControl();
            this.sP_GetAllSubOfGrade_TeacherBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.kiemTraHSDataSet = new PTTKHTTT.KiemTraHSDataSet();
            this.subsTileView = new DevExpress.XtraGrid.Views.Tile.TileView();
            this.colMaMon1 = new DevExpress.XtraGrid.Columns.TileViewColumn();
            this.colKhoi1 = new DevExpress.XtraGrid.Columns.TileViewColumn();
            this.cardView1 = new DevExpress.XtraGrid.Views.Card.CardView();
            this.childContainer = new DevExpress.XtraEditors.PanelControl();
            this.quesForm = new DevExpress.XtraEditors.PanelControl();
            this.groupControl5 = new DevExpress.XtraEditors.GroupControl();
            this.groupControl1 = new DevExpress.XtraEditors.GroupControl();
            this.panelControl2 = new DevExpress.XtraEditors.PanelControl();
            this.lessonLabelControl = new DevExpress.XtraEditors.LabelControl();
            this.labelControl1 = new DevExpress.XtraEditors.LabelControl();
            this.dataEntryGroupControl = new DevExpress.XtraEditors.GroupControl();
            this.statusCheckEdit = new DevExpress.XtraEditors.CheckEdit();
            this.quesBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.barManager1 = new DevExpress.XtraBars.BarManager(this.components);
            this.barDockControlTop = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlBottom = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlLeft = new DevExpress.XtraBars.BarDockControl();
            this.barDockControlRight = new DevExpress.XtraBars.BarDockControl();
            this.ansComboBox = new System.Windows.Forms.ComboBox();
            this.dOptionRichTextBox = new System.Windows.Forms.RichTextBox();
            this.cOptionRichTextBox = new System.Windows.Forms.RichTextBox();
            this.bOptionRichTextBox = new System.Windows.Forms.RichTextBox();
            this.aOptionRichTextBox = new System.Windows.Forms.RichTextBox();
            this.contentRichTextBox = new System.Windows.Forms.RichTextBox();
            this.panelControl1 = new DevExpress.XtraEditors.PanelControl();
            this.flowLayoutPanel1 = new System.Windows.Forms.FlowLayoutPanel();
            this.addBtn = new DevExpress.XtraEditors.SimpleButton();
            this.editBtn = new DevExpress.XtraEditors.SimpleButton();
            this.saveBtn = new DevExpress.XtraEditors.SimpleButton();
            this.undoBtn = new DevExpress.XtraEditors.SimpleButton();
            this.deleteBtn = new DevExpress.XtraEditors.SimpleButton();
            this.exitBtn = new DevExpress.XtraEditors.SimpleButton();
            this.quesGridControl = new DevExpress.XtraGrid.GridControl();
            this.quesGridView = new DevExpress.XtraGrid.Views.Grid.GridView();
            this.colNoiDung = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colA = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colB = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colC = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colD = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colDapAn = new DevExpress.XtraGrid.Columns.GridColumn();
            this.colTrangThai = new DevExpress.XtraGrid.Columns.GridColumn();
            this.groupControl3 = new DevExpress.XtraEditors.GroupControl();
            this.treeViewLessons = new System.Windows.Forms.TreeView();
            this.nH_CAUHOIBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.sP_GetAllSubOfGrade_TeacherTableAdapter1 = new PTTKHTTT.KiemTraHSDataSetTableAdapters.SP_GetAllSubOfGrade_TeacherTableAdapter();
            this.quesTableAdapter = new PTTKHTTT.KiemTraHSDataSetTableAdapters.SP_GetAllQuesByLessonTableAdapter();
            this.tableAdapterManager = new PTTKHTTT.KiemTraHSDataSetTableAdapters.TableAdapterManager();
            this.barManager2 = new DevExpress.XtraBars.BarManager(this.components);
            this.barDockControl1 = new DevExpress.XtraBars.BarDockControl();
            this.barDockControl2 = new DevExpress.XtraBars.BarDockControl();
            this.barDockControl3 = new DevExpress.XtraBars.BarDockControl();
            this.barDockControl4 = new DevExpress.XtraBars.BarDockControl();
            this.barButtonItem1 = new DevExpress.XtraBars.BarButtonItem();
            this.barManager3 = new DevExpress.XtraBars.BarManager(this.components);
            this.barDockControl5 = new DevExpress.XtraBars.BarDockControl();
            this.barDockControl6 = new DevExpress.XtraBars.BarDockControl();
            this.barDockControl7 = new DevExpress.XtraBars.BarDockControl();
            this.barDockControl8 = new DevExpress.XtraBars.BarDockControl();
            this.bar5 = new DevExpress.XtraBars.Bar();
            this.bar2 = new DevExpress.XtraBars.Bar();
            this.barManager4 = new DevExpress.XtraBars.BarManager(this.components);
            this.barDockControl9 = new DevExpress.XtraBars.BarDockControl();
            this.barDockControl10 = new DevExpress.XtraBars.BarDockControl();
            this.barDockControl11 = new DevExpress.XtraBars.BarDockControl();
            this.barDockControl12 = new DevExpress.XtraBars.BarDockControl();
            this.barManager5 = new DevExpress.XtraBars.BarManager(this.components);
            this.barDockControl13 = new DevExpress.XtraBars.BarDockControl();
            this.barDockControl14 = new DevExpress.XtraBars.BarDockControl();
            this.barDockControl15 = new DevExpress.XtraBars.BarDockControl();
            this.barDockControl16 = new DevExpress.XtraBars.BarDockControl();
            this.nH_CAUHOITableAdapter = new PTTKHTTT.KiemTraHSDataSetTableAdapters.NH_CAUHOITableAdapter();
            noiDungLabel = new System.Windows.Forms.Label();
            aLabel = new System.Windows.Forms.Label();
            bLabel = new System.Windows.Forms.Label();
            cLabel = new System.Windows.Forms.Label();
            dLabel = new System.Windows.Forms.Label();
            dapAnLabel = new System.Windows.Forms.Label();
            trangThaiLabel = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemCheckEdit1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.sP_GetAllSubOfGrade_TeacherGridControl)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.sP_GetAllSubOfGrade_TeacherBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.kiemTraHSDataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.subsTileView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.cardView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.childContainer)).BeginInit();
            this.childContainer.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.quesForm)).BeginInit();
            this.quesForm.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.groupControl5)).BeginInit();
            this.groupControl5.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).BeginInit();
            this.groupControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl2)).BeginInit();
            this.panelControl2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataEntryGroupControl)).BeginInit();
            this.dataEntryGroupControl.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.statusCheckEdit.Properties)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.quesBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).BeginInit();
            this.panelControl1.SuspendLayout();
            this.flowLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.quesGridControl)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.quesGridView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.groupControl3)).BeginInit();
            this.groupControl3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.nH_CAUHOIBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager5)).BeginInit();
            this.SuspendLayout();
            // 
            // noiDungLabel
            // 
            noiDungLabel.AutoSize = true;
            noiDungLabel.Location = new System.Drawing.Point(96, 52);
            noiDungLabel.Name = "noiDungLabel";
            noiDungLabel.Size = new System.Drawing.Size(59, 13);
            noiDungLabel.TabIndex = 0;
            noiDungLabel.Text = "Nội dung:";
            // 
            // aLabel
            // 
            aLabel.AutoSize = true;
            aLabel.Location = new System.Drawing.Point(131, 143);
            aLabel.Name = "aLabel";
            aLabel.Size = new System.Drawing.Size(17, 13);
            aLabel.TabIndex = 2;
            aLabel.Text = "A:";
            // 
            // bLabel
            // 
            bLabel.AutoSize = true;
            bLabel.Location = new System.Drawing.Point(460, 142);
            bLabel.Name = "bLabel";
            bLabel.Size = new System.Drawing.Size(16, 13);
            bLabel.TabIndex = 4;
            bLabel.Text = "B:";
            // 
            // cLabel
            // 
            cLabel.AutoSize = true;
            cLabel.Location = new System.Drawing.Point(132, 217);
            cLabel.Name = "cLabel";
            cLabel.Size = new System.Drawing.Size(17, 13);
            cLabel.TabIndex = 6;
            cLabel.Text = "C:";
            // 
            // dLabel
            // 
            dLabel.AutoSize = true;
            dLabel.Location = new System.Drawing.Point(459, 217);
            dLabel.Name = "dLabel";
            dLabel.Size = new System.Drawing.Size(18, 13);
            dLabel.TabIndex = 8;
            dLabel.Text = "D:";
            // 
            // dapAnLabel
            // 
            dapAnLabel.AutoSize = true;
            dapAnLabel.Location = new System.Drawing.Point(96, 286);
            dapAnLabel.Name = "dapAnLabel";
            dapAnLabel.Size = new System.Drawing.Size(47, 13);
            dapAnLabel.TabIndex = 10;
            dapAnLabel.Text = "Đáp án:";
            // 
            // trangThaiLabel
            // 
            trangThaiLabel.AutoSize = true;
            trangThaiLabel.Location = new System.Drawing.Point(460, 286);
            trangThaiLabel.Name = "trangThaiLabel";
            trangThaiLabel.Size = new System.Drawing.Size(108, 13);
            trangThaiLabel.TabIndex = 12;
            trangThaiLabel.Text = "Trạng thái sử dụng:";
            // 
            // colTenMon1
            // 
            this.colTenMon1.FieldName = "TenMon";
            this.colTenMon1.Name = "colTenMon1";
            this.colTenMon1.Visible = true;
            this.colTenMon1.VisibleIndex = 1;
            // 
            // repositoryItemCheckEdit1
            // 
            this.repositoryItemCheckEdit1.AutoHeight = false;
            this.repositoryItemCheckEdit1.Name = "repositoryItemCheckEdit1";
            // 
            // sP_GetAllSubOfGrade_TeacherGridControl
            // 
            this.sP_GetAllSubOfGrade_TeacherGridControl.DataSource = this.sP_GetAllSubOfGrade_TeacherBindingSource;
            this.sP_GetAllSubOfGrade_TeacherGridControl.Location = new System.Drawing.Point(5, 26);
            this.sP_GetAllSubOfGrade_TeacherGridControl.MainView = this.subsTileView;
            this.sP_GetAllSubOfGrade_TeacherGridControl.Name = "sP_GetAllSubOfGrade_TeacherGridControl";
            this.sP_GetAllSubOfGrade_TeacherGridControl.Size = new System.Drawing.Size(616, 443);
            this.sP_GetAllSubOfGrade_TeacherGridControl.TabIndex = 2;
            this.sP_GetAllSubOfGrade_TeacherGridControl.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.subsTileView,
            this.cardView1});
            // 
            // sP_GetAllSubOfGrade_TeacherBindingSource
            // 
            this.sP_GetAllSubOfGrade_TeacherBindingSource.DataMember = "SP_GetAllSubOfGrade_Teacher";
            this.sP_GetAllSubOfGrade_TeacherBindingSource.DataSource = this.kiemTraHSDataSet;
            // 
            // kiemTraHSDataSet
            // 
            this.kiemTraHSDataSet.DataSetName = "KiemTraHSDataSet1";
            this.kiemTraHSDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // subsTileView
            // 
            this.subsTileView.Appearance.ItemNormal.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            this.subsTileView.Appearance.ItemNormal.Font = new System.Drawing.Font("Segoe UI Symbol", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.subsTileView.Appearance.ItemNormal.Options.UseBackColor = true;
            this.subsTileView.Appearance.ItemNormal.Options.UseFont = true;
            this.subsTileView.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.colMaMon1,
            this.colTenMon1,
            this.colKhoi1});
            this.subsTileView.ColumnSet.GroupColumn = this.colKhoi1;
            this.subsTileView.GridControl = this.sP_GetAllSubOfGrade_TeacherGridControl;
            this.subsTileView.Name = "subsTileView";
            this.subsTileView.OptionsTiles.ColumnCount = 2;
            this.subsTileView.OptionsTiles.GroupTextPadding = new System.Windows.Forms.Padding(24, 0, 0, 16);
            this.subsTileView.OptionsTiles.IndentBetweenGroups = 57;
            this.subsTileView.OptionsTiles.IndentBetweenItems = 4;
            this.subsTileView.OptionsTiles.ItemPadding = new System.Windows.Forms.Padding(0);
            this.subsTileView.OptionsTiles.ItemSize = new System.Drawing.Size(220, 80);
            this.subsTileView.OptionsTiles.Padding = new System.Windows.Forms.Padding(30);
            this.subsTileView.OptionsTiles.RowCount = 3;
            this.subsTileView.SortInfo.AddRange(new DevExpress.XtraGrid.Columns.GridColumnSortInfo[] {
            new DevExpress.XtraGrid.Columns.GridColumnSortInfo(this.colKhoi1, DevExpress.Data.ColumnSortOrder.Ascending)});
            this.subsTileView.TileColumns.Add(tableColumnDefinition1);
            this.subsTileView.TileColumns.Add(tableColumnDefinition2);
            this.subsTileView.TileColumns.Add(tableColumnDefinition3);
            this.subsTileView.TileRows.Add(tableRowDefinition1);
            this.subsTileView.TileRows.Add(tableRowDefinition2);
            this.subsTileView.TileRows.Add(tableRowDefinition3);
            tileViewItemElement1.Column = this.colTenMon1;
            tileViewItemElement1.ColumnIndex = 1;
            tileViewItemElement1.ImageOptions.ImageAlignment = DevExpress.XtraEditors.TileItemContentAlignment.MiddleCenter;
            tileViewItemElement1.ImageOptions.ImageScaleMode = DevExpress.XtraEditors.TileItemImageScaleMode.ZoomInside;
            tileViewItemElement1.RowIndex = 1;
            tileViewItemElement1.Text = "colTenMon1";
            tileViewItemElement1.TextAlignment = DevExpress.XtraEditors.TileItemContentAlignment.MiddleCenter;
            this.subsTileView.TileTemplate.Add(tileViewItemElement1);
            this.subsTileView.Click += new System.EventHandler(this.subsTileView_Click);
            // 
            // colMaMon1
            // 
            this.colMaMon1.FieldName = "MaMon";
            this.colMaMon1.Name = "colMaMon1";
            this.colMaMon1.Visible = true;
            this.colMaMon1.VisibleIndex = 0;
            // 
            // colKhoi1
            // 
            this.colKhoi1.FieldName = "Khoi";
            this.colKhoi1.Name = "colKhoi1";
            this.colKhoi1.Visible = true;
            this.colKhoi1.VisibleIndex = 2;
            // 
            // cardView1
            // 
            this.cardView1.GridControl = this.sP_GetAllSubOfGrade_TeacherGridControl;
            this.cardView1.Name = "cardView1";
            // 
            // childContainer
            // 
            this.childContainer.Controls.Add(this.quesForm);
            this.childContainer.Controls.Add(this.sP_GetAllSubOfGrade_TeacherGridControl);
            this.childContainer.Dock = System.Windows.Forms.DockStyle.Fill;
            this.childContainer.Location = new System.Drawing.Point(0, 0);
            this.childContainer.Name = "childContainer";
            this.childContainer.Size = new System.Drawing.Size(1122, 670);
            this.childContainer.TabIndex = 3;
            // 
            // quesForm
            // 
            this.quesForm.Controls.Add(this.groupControl5);
            this.quesForm.Controls.Add(this.groupControl3);
            this.quesForm.Dock = System.Windows.Forms.DockStyle.Fill;
            this.quesForm.Location = new System.Drawing.Point(2, 2);
            this.quesForm.Name = "quesForm";
            this.quesForm.Size = new System.Drawing.Size(1118, 666);
            this.quesForm.TabIndex = 3;
            // 
            // groupControl5
            // 
            this.groupControl5.Controls.Add(this.groupControl1);
            this.groupControl5.Dock = System.Windows.Forms.DockStyle.Right;
            this.groupControl5.Location = new System.Drawing.Point(307, 2);
            this.groupControl5.Name = "groupControl5";
            this.groupControl5.Size = new System.Drawing.Size(809, 662);
            this.groupControl5.TabIndex = 15;
            this.groupControl5.Text = "Danh sách câu hỏi";
            // 
            // groupControl1
            // 
            this.groupControl1.Controls.Add(this.panelControl2);
            this.groupControl1.Controls.Add(this.dataEntryGroupControl);
            this.groupControl1.Controls.Add(this.panelControl1);
            this.groupControl1.Controls.Add(this.quesGridControl);
            this.groupControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupControl1.Location = new System.Drawing.Point(2, 27);
            this.groupControl1.Name = "groupControl1";
            this.groupControl1.ShowCaption = false;
            this.groupControl1.Size = new System.Drawing.Size(805, 633);
            this.groupControl1.TabIndex = 11;
            this.groupControl1.Text = "groupControl1";
            // 
            // panelControl2
            // 
            this.panelControl2.Controls.Add(this.lessonLabelControl);
            this.panelControl2.Controls.Add(this.labelControl1);
            this.panelControl2.Location = new System.Drawing.Point(2, 45);
            this.panelControl2.Name = "panelControl2";
            this.panelControl2.Size = new System.Drawing.Size(801, 40);
            this.panelControl2.TabIndex = 11;
            // 
            // lessonLabelControl
            // 
            this.lessonLabelControl.Appearance.Font = new System.Drawing.Font("Segoe UI Symbol", 9.75F, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lessonLabelControl.Appearance.Options.UseFont = true;
            this.lessonLabelControl.Location = new System.Drawing.Point(82, 11);
            this.lessonLabelControl.Name = "lessonLabelControl";
            this.lessonLabelControl.Size = new System.Drawing.Size(0, 17);
            this.lessonLabelControl.TabIndex = 11;
            this.lessonLabelControl.TextChanged += new System.EventHandler(this.lessonLabelControl_TextChanged);
            // 
            // labelControl1
            // 
            this.labelControl1.Appearance.Font = new System.Drawing.Font("Segoe UI Symbol", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelControl1.Appearance.Options.UseFont = true;
            this.labelControl1.Location = new System.Drawing.Point(12, 11);
            this.labelControl1.Name = "labelControl1";
            this.labelControl1.Size = new System.Drawing.Size(53, 17);
            this.labelControl1.TabIndex = 10;
            this.labelControl1.Text = "Bài học:";
            // 
            // dataEntryGroupControl
            // 
            this.dataEntryGroupControl.Controls.Add(trangThaiLabel);
            this.dataEntryGroupControl.Controls.Add(this.statusCheckEdit);
            this.dataEntryGroupControl.Controls.Add(dapAnLabel);
            this.dataEntryGroupControl.Controls.Add(this.ansComboBox);
            this.dataEntryGroupControl.Controls.Add(dLabel);
            this.dataEntryGroupControl.Controls.Add(this.dOptionRichTextBox);
            this.dataEntryGroupControl.Controls.Add(cLabel);
            this.dataEntryGroupControl.Controls.Add(this.cOptionRichTextBox);
            this.dataEntryGroupControl.Controls.Add(bLabel);
            this.dataEntryGroupControl.Controls.Add(this.bOptionRichTextBox);
            this.dataEntryGroupControl.Controls.Add(aLabel);
            this.dataEntryGroupControl.Controls.Add(this.aOptionRichTextBox);
            this.dataEntryGroupControl.Controls.Add(noiDungLabel);
            this.dataEntryGroupControl.Controls.Add(this.contentRichTextBox);
            this.dataEntryGroupControl.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.dataEntryGroupControl.Enabled = false;
            this.dataEntryGroupControl.Location = new System.Drawing.Point(2, 320);
            this.dataEntryGroupControl.Name = "dataEntryGroupControl";
            this.dataEntryGroupControl.Size = new System.Drawing.Size(801, 311);
            this.dataEntryGroupControl.TabIndex = 11;
            this.dataEntryGroupControl.Text = "Chi tiết câu hỏi";
            // 
            // statusCheckEdit
            // 
            this.statusCheckEdit.DataBindings.Add(new System.Windows.Forms.Binding("EditValue", this.quesBindingSource, "TrangThai", true));
            this.statusCheckEdit.EditValue = true;
            this.statusCheckEdit.Location = new System.Drawing.Point(604, 283);
            this.statusCheckEdit.MenuManager = this.barManager1;
            this.statusCheckEdit.Name = "statusCheckEdit";
            this.statusCheckEdit.Properties.Caption = "Sử dụng";
            this.statusCheckEdit.Size = new System.Drawing.Size(75, 20);
            this.statusCheckEdit.TabIndex = 13;
            // 
            // quesBindingSource
            // 
            this.quesBindingSource.DataMember = "SP_GetAllQuesByLesson";
            this.quesBindingSource.DataSource = this.kiemTraHSDataSet;
            // 
            // barManager1
            // 
            this.barManager1.DockControls.Add(this.barDockControlTop);
            this.barManager1.DockControls.Add(this.barDockControlBottom);
            this.barManager1.DockControls.Add(this.barDockControlLeft);
            this.barManager1.DockControls.Add(this.barDockControlRight);
            this.barManager1.Form = this;
            // 
            // barDockControlTop
            // 
            this.barDockControlTop.CausesValidation = false;
            this.barDockControlTop.Dock = System.Windows.Forms.DockStyle.Top;
            this.barDockControlTop.Location = new System.Drawing.Point(0, 0);
            this.barDockControlTop.Manager = this.barManager1;
            this.barDockControlTop.Size = new System.Drawing.Size(1122, 0);
            // 
            // barDockControlBottom
            // 
            this.barDockControlBottom.CausesValidation = false;
            this.barDockControlBottom.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.barDockControlBottom.Location = new System.Drawing.Point(0, 670);
            this.barDockControlBottom.Manager = this.barManager1;
            this.barDockControlBottom.Size = new System.Drawing.Size(1122, 0);
            // 
            // barDockControlLeft
            // 
            this.barDockControlLeft.CausesValidation = false;
            this.barDockControlLeft.Dock = System.Windows.Forms.DockStyle.Left;
            this.barDockControlLeft.Location = new System.Drawing.Point(0, 0);
            this.barDockControlLeft.Manager = this.barManager1;
            this.barDockControlLeft.Size = new System.Drawing.Size(0, 670);
            // 
            // barDockControlRight
            // 
            this.barDockControlRight.CausesValidation = false;
            this.barDockControlRight.Dock = System.Windows.Forms.DockStyle.Right;
            this.barDockControlRight.Location = new System.Drawing.Point(1122, 0);
            this.barDockControlRight.Manager = this.barManager1;
            this.barDockControlRight.Size = new System.Drawing.Size(0, 670);
            // 
            // ansComboBox
            // 
            this.ansComboBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.quesBindingSource, "DapAn", true));
            this.ansComboBox.FormattingEnabled = true;
            this.ansComboBox.Items.AddRange(new object[] {
            "A",
            "B",
            "C",
            "D"});
            this.ansComboBox.Location = new System.Drawing.Point(156, 286);
            this.ansComboBox.Name = "ansComboBox";
            this.ansComboBox.Size = new System.Drawing.Size(200, 21);
            this.ansComboBox.TabIndex = 11;
            // 
            // dOptionRichTextBox
            // 
            this.dOptionRichTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.quesBindingSource, "D", true));
            this.dOptionRichTextBox.Location = new System.Drawing.Point(478, 214);
            this.dOptionRichTextBox.Name = "dOptionRichTextBox";
            this.dOptionRichTextBox.Size = new System.Drawing.Size(201, 49);
            this.dOptionRichTextBox.TabIndex = 9;
            this.dOptionRichTextBox.Text = "";
            // 
            // cOptionRichTextBox
            // 
            this.cOptionRichTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.quesBindingSource, "C", true));
            this.cOptionRichTextBox.Location = new System.Drawing.Point(156, 214);
            this.cOptionRichTextBox.Name = "cOptionRichTextBox";
            this.cOptionRichTextBox.Size = new System.Drawing.Size(200, 49);
            this.cOptionRichTextBox.TabIndex = 7;
            this.cOptionRichTextBox.Text = "";
            // 
            // bOptionRichTextBox
            // 
            this.bOptionRichTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.quesBindingSource, "B", true));
            this.bOptionRichTextBox.Location = new System.Drawing.Point(479, 143);
            this.bOptionRichTextBox.Name = "bOptionRichTextBox";
            this.bOptionRichTextBox.Size = new System.Drawing.Size(200, 49);
            this.bOptionRichTextBox.TabIndex = 5;
            this.bOptionRichTextBox.Text = "";
            // 
            // aOptionRichTextBox
            // 
            this.aOptionRichTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.quesBindingSource, "A", true));
            this.aOptionRichTextBox.Location = new System.Drawing.Point(156, 143);
            this.aOptionRichTextBox.Name = "aOptionRichTextBox";
            this.aOptionRichTextBox.Size = new System.Drawing.Size(200, 48);
            this.aOptionRichTextBox.TabIndex = 3;
            this.aOptionRichTextBox.Text = "";
            // 
            // contentRichTextBox
            // 
            this.contentRichTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.quesBindingSource, "NoiDung", true));
            this.contentRichTextBox.Location = new System.Drawing.Point(156, 49);
            this.contentRichTextBox.Name = "contentRichTextBox";
            this.contentRichTextBox.Size = new System.Drawing.Size(523, 69);
            this.contentRichTextBox.TabIndex = 1;
            this.contentRichTextBox.Text = "";
            // 
            // panelControl1
            // 
            this.panelControl1.Controls.Add(this.flowLayoutPanel1);
            this.panelControl1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panelControl1.Location = new System.Drawing.Point(2, 2);
            this.panelControl1.Name = "panelControl1";
            this.panelControl1.Size = new System.Drawing.Size(801, 45);
            this.panelControl1.TabIndex = 10;
            // 
            // flowLayoutPanel1
            // 
            this.flowLayoutPanel1.Controls.Add(this.addBtn);
            this.flowLayoutPanel1.Controls.Add(this.editBtn);
            this.flowLayoutPanel1.Controls.Add(this.saveBtn);
            this.flowLayoutPanel1.Controls.Add(this.undoBtn);
            this.flowLayoutPanel1.Controls.Add(this.deleteBtn);
            this.flowLayoutPanel1.Controls.Add(this.exitBtn);
            this.flowLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.flowLayoutPanel1.Location = new System.Drawing.Point(2, 2);
            this.flowLayoutPanel1.Name = "flowLayoutPanel1";
            this.flowLayoutPanel1.Size = new System.Drawing.Size(797, 41);
            this.flowLayoutPanel1.TabIndex = 9;
            // 
            // addBtn
            // 
            this.addBtn.Enabled = false;
            this.addBtn.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("addBtn.ImageOptions.Image")));
            this.addBtn.ImageOptions.ImageToTextAlignment = DevExpress.XtraEditors.ImageAlignToText.LeftCenter;
            this.addBtn.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.addBtn.Location = new System.Drawing.Point(3, 3);
            this.addBtn.Name = "addBtn";
            this.addBtn.Size = new System.Drawing.Size(126, 32);
            this.addBtn.TabIndex = 0;
            this.addBtn.Text = "Thêm mới";
            this.addBtn.EnabledChanged += new System.EventHandler(this.addBtn_EnabledChanged);
            this.addBtn.Click += new System.EventHandler(this.addBtn_Click);
            // 
            // editBtn
            // 
            this.editBtn.Enabled = false;
            this.editBtn.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("editBtn.ImageOptions.Image")));
            this.editBtn.ImageOptions.ImageToTextAlignment = DevExpress.XtraEditors.ImageAlignToText.LeftCenter;
            this.editBtn.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.editBtn.Location = new System.Drawing.Point(135, 3);
            this.editBtn.Name = "editBtn";
            this.editBtn.Size = new System.Drawing.Size(126, 32);
            this.editBtn.TabIndex = 5;
            this.editBtn.Text = "Hiệu chỉnh";
            this.editBtn.Click += new System.EventHandler(this.editBtn_Click);
            // 
            // saveBtn
            // 
            this.saveBtn.Enabled = false;
            this.saveBtn.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("saveBtn.ImageOptions.Image")));
            this.saveBtn.ImageOptions.ImageToTextAlignment = DevExpress.XtraEditors.ImageAlignToText.LeftCenter;
            this.saveBtn.ImeMode = System.Windows.Forms.ImeMode.NoControl;
            this.saveBtn.Location = new System.Drawing.Point(267, 3);
            this.saveBtn.Name = "saveBtn";
            this.saveBtn.Size = new System.Drawing.Size(126, 32);
            this.saveBtn.TabIndex = 4;
            this.saveBtn.Text = "Lưu";
            this.saveBtn.Click += new System.EventHandler(this.saveBtn_Click);
            // 
            // undoBtn
            // 
            this.undoBtn.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("undoBtn.ImageOptions.Image")));
            this.undoBtn.ImageOptions.ImageToTextAlignment = DevExpress.XtraEditors.ImageAlignToText.LeftCenter;
            this.undoBtn.Location = new System.Drawing.Point(399, 3);
            this.undoBtn.Name = "undoBtn";
            this.undoBtn.Size = new System.Drawing.Size(126, 32);
            this.undoBtn.TabIndex = 1;
            this.undoBtn.Text = "Phục hồi";
            this.undoBtn.Click += new System.EventHandler(this.undoBtn_Click);
            // 
            // deleteBtn
            // 
            this.deleteBtn.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("deleteBtn.ImageOptions.Image")));
            this.deleteBtn.ImageOptions.ImageToTextAlignment = DevExpress.XtraEditors.ImageAlignToText.LeftCenter;
            this.deleteBtn.Location = new System.Drawing.Point(531, 3);
            this.deleteBtn.Name = "deleteBtn";
            this.deleteBtn.Size = new System.Drawing.Size(126, 32);
            this.deleteBtn.TabIndex = 2;
            this.deleteBtn.Text = "Xoá";
            this.deleteBtn.Click += new System.EventHandler(this.deleteBtn_Click);
            // 
            // exitBtn
            // 
            this.exitBtn.ImageOptions.Image = ((System.Drawing.Image)(resources.GetObject("exitBtn.ImageOptions.Image")));
            this.exitBtn.ImageOptions.ImageToTextAlignment = DevExpress.XtraEditors.ImageAlignToText.LeftCenter;
            this.exitBtn.Location = new System.Drawing.Point(663, 3);
            this.exitBtn.Name = "exitBtn";
            this.exitBtn.Size = new System.Drawing.Size(126, 32);
            this.exitBtn.TabIndex = 3;
            this.exitBtn.Text = "Thoát";
            this.exitBtn.Click += new System.EventHandler(this.exitBtn_Click);
            // 
            // quesGridControl
            // 
            this.quesGridControl.DataSource = this.quesBindingSource;
            this.quesGridControl.Location = new System.Drawing.Point(7, 105);
            this.quesGridControl.MainView = this.quesGridView;
            this.quesGridControl.Name = "quesGridControl";
            this.quesGridControl.Size = new System.Drawing.Size(793, 209);
            this.quesGridControl.TabIndex = 8;
            this.quesGridControl.ViewCollection.AddRange(new DevExpress.XtraGrid.Views.Base.BaseView[] {
            this.quesGridView});
            // 
            // quesGridView
            // 
            this.quesGridView.Columns.AddRange(new DevExpress.XtraGrid.Columns.GridColumn[] {
            this.colNoiDung,
            this.colA,
            this.colB,
            this.colC,
            this.colD,
            this.colDapAn,
            this.colTrangThai});
            this.quesGridView.GridControl = this.quesGridControl;
            this.quesGridView.Name = "quesGridView";
            this.quesGridView.OptionsBehavior.Editable = false;
            this.quesGridView.OptionsSelection.EnableAppearanceFocusedCell = false;
            this.quesGridView.OptionsView.ShowGroupPanel = false;
            this.quesGridView.OptionsView.ShowIndicator = false;
            this.quesGridView.RowCellClick += new DevExpress.XtraGrid.Views.Grid.RowCellClickEventHandler(this.gridView1_RowCellClick);
            this.quesGridView.FocusedRowChanged += new DevExpress.XtraGrid.Views.Base.FocusedRowChangedEventHandler(this.gridView1_FocusedRowChanged);
            this.quesGridView.RowCountChanged += new System.EventHandler(this.gridView1_RowCountChanged);
            // 
            // colNoiDung
            // 
            this.colNoiDung.Caption = "Nội dung";
            this.colNoiDung.FieldName = "NoiDung";
            this.colNoiDung.Name = "colNoiDung";
            this.colNoiDung.Visible = true;
            this.colNoiDung.VisibleIndex = 0;
            this.colNoiDung.Width = 196;
            // 
            // colA
            // 
            this.colA.Caption = "A";
            this.colA.FieldName = "A";
            this.colA.Name = "colA";
            this.colA.Visible = true;
            this.colA.VisibleIndex = 1;
            this.colA.Width = 100;
            // 
            // colB
            // 
            this.colB.Caption = "B";
            this.colB.FieldName = "B";
            this.colB.Name = "colB";
            this.colB.Visible = true;
            this.colB.VisibleIndex = 2;
            this.colB.Width = 100;
            // 
            // colC
            // 
            this.colC.Caption = "C";
            this.colC.FieldName = "C";
            this.colC.Name = "colC";
            this.colC.Visible = true;
            this.colC.VisibleIndex = 3;
            this.colC.Width = 100;
            // 
            // colD
            // 
            this.colD.Caption = "D";
            this.colD.FieldName = "D";
            this.colD.Name = "colD";
            this.colD.Visible = true;
            this.colD.VisibleIndex = 4;
            this.colD.Width = 100;
            // 
            // colDapAn
            // 
            this.colDapAn.Caption = "Đáp án";
            this.colDapAn.FieldName = "DapAn";
            this.colDapAn.Name = "colDapAn";
            this.colDapAn.Visible = true;
            this.colDapAn.VisibleIndex = 5;
            this.colDapAn.Width = 50;
            // 
            // colTrangThai
            // 
            this.colTrangThai.Caption = "Trạng thái";
            this.colTrangThai.ColumnEdit = this.repositoryItemCheckEdit1;
            this.colTrangThai.FieldName = "TrangThai";
            this.colTrangThai.Name = "colTrangThai";
            this.colTrangThai.Visible = true;
            this.colTrangThai.VisibleIndex = 6;
            this.colTrangThai.Width = 50;
            // 
            // groupControl3
            // 
            this.groupControl3.Controls.Add(this.treeViewLessons);
            this.groupControl3.Dock = System.Windows.Forms.DockStyle.Left;
            this.groupControl3.Location = new System.Drawing.Point(2, 2);
            this.groupControl3.Name = "groupControl3";
            this.groupControl3.Size = new System.Drawing.Size(301, 662);
            this.groupControl3.TabIndex = 12;
            this.groupControl3.Text = "Danh sách bài học";
            // 
            // treeViewLessons
            // 
            this.treeViewLessons.Dock = System.Windows.Forms.DockStyle.Fill;
            this.treeViewLessons.Location = new System.Drawing.Point(2, 27);
            this.treeViewLessons.Name = "treeViewLessons";
            treeNode1.Name = "rootNodeFirstTerm";
            treeNode1.Tag = "1";
            treeNode1.Text = "Học kỳ 1";
            treeNode2.Name = "rootNodeSecondTerm";
            treeNode2.Tag = "2";
            treeNode2.Text = "Học kỳ 2";
            this.treeViewLessons.Nodes.AddRange(new System.Windows.Forms.TreeNode[] {
            treeNode1,
            treeNode2});
            this.treeViewLessons.Size = new System.Drawing.Size(297, 633);
            this.treeViewLessons.TabIndex = 10;
            this.treeViewLessons.NodeMouseClick += new System.Windows.Forms.TreeNodeMouseClickEventHandler(this.treeViewLessons_NodeMouseClick);
            // 
            // nH_CAUHOIBindingSource
            // 
            this.nH_CAUHOIBindingSource.DataMember = "NH_CAUHOI";
            this.nH_CAUHOIBindingSource.DataSource = this.kiemTraHSDataSet;
            // 
            // sP_GetAllSubOfGrade_TeacherTableAdapter1
            // 
            this.sP_GetAllSubOfGrade_TeacherTableAdapter1.ClearBeforeFill = true;
            // 
            // quesTableAdapter
            // 
            this.quesTableAdapter.ClearBeforeFill = true;
            // 
            // tableAdapterManager
            // 
            this.tableAdapterManager.BackupDataSetBeforeUpdate = false;
            this.tableAdapterManager.BAIHOCKTTableAdapter = null;
            this.tableAdapterManager.BAIHOCTableAdapter = null;
            this.tableAdapterManager.Connection = null;
            this.tableAdapterManager.CT_BAITHITableAdapter = null;
            this.tableAdapterManager.DANGKYKIEMTRATableAdapter = null;
            this.tableAdapterManager.DIEMTableAdapter = null;
            this.tableAdapterManager.GIAOVIENTableAdapter = null;
            this.tableAdapterManager.GV_MONTableAdapter = null;
            this.tableAdapterManager.HOCKYTableAdapter = null;
            this.tableAdapterManager.HOCSINHTableAdapter = null;
            this.tableAdapterManager.KHOITableAdapter = null;
            this.tableAdapterManager.LOAIKIEMTRATableAdapter = null;
            this.tableAdapterManager.LOPKTTableAdapter = null;
            this.tableAdapterManager.LOPTableAdapter = null;
            this.tableAdapterManager.MONTableAdapter = null;
            this.tableAdapterManager.NH_CAUHOITableAdapter = null;
            this.tableAdapterManager.PC_GIANGDAYTableAdapter = null;
            this.tableAdapterManager.UpdateOrder = PTTKHTTT.KiemTraHSDataSetTableAdapters.TableAdapterManager.UpdateOrderOption.InsertUpdateDelete;
            // 
            // barManager2
            // 
            this.barManager2.DockControls.Add(this.barDockControl1);
            this.barManager2.DockControls.Add(this.barDockControl2);
            this.barManager2.DockControls.Add(this.barDockControl3);
            this.barManager2.DockControls.Add(this.barDockControl4);
            this.barManager2.Form = this;
            this.barManager2.Items.AddRange(new DevExpress.XtraBars.BarItem[] {
            this.barButtonItem1});
            this.barManager2.MaxItemId = 1;
            // 
            // barDockControl1
            // 
            this.barDockControl1.CausesValidation = false;
            this.barDockControl1.Dock = System.Windows.Forms.DockStyle.Top;
            this.barDockControl1.Location = new System.Drawing.Point(0, 0);
            this.barDockControl1.Manager = this.barManager2;
            this.barDockControl1.Size = new System.Drawing.Size(1122, 0);
            // 
            // barDockControl2
            // 
            this.barDockControl2.CausesValidation = false;
            this.barDockControl2.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.barDockControl2.Location = new System.Drawing.Point(0, 670);
            this.barDockControl2.Manager = this.barManager2;
            this.barDockControl2.Size = new System.Drawing.Size(1122, 0);
            // 
            // barDockControl3
            // 
            this.barDockControl3.CausesValidation = false;
            this.barDockControl3.Dock = System.Windows.Forms.DockStyle.Left;
            this.barDockControl3.Location = new System.Drawing.Point(0, 0);
            this.barDockControl3.Manager = this.barManager2;
            this.barDockControl3.Size = new System.Drawing.Size(0, 670);
            // 
            // barDockControl4
            // 
            this.barDockControl4.CausesValidation = false;
            this.barDockControl4.Dock = System.Windows.Forms.DockStyle.Right;
            this.barDockControl4.Location = new System.Drawing.Point(1122, 0);
            this.barDockControl4.Manager = this.barManager2;
            this.barDockControl4.Size = new System.Drawing.Size(0, 670);
            // 
            // barButtonItem1
            // 
            this.barButtonItem1.Caption = "barButtonItem1";
            this.barButtonItem1.Id = 0;
            this.barButtonItem1.Name = "barButtonItem1";
            // 
            // barManager3
            // 
            this.barManager3.DockControls.Add(this.barDockControl5);
            this.barManager3.DockControls.Add(this.barDockControl6);
            this.barManager3.DockControls.Add(this.barDockControl7);
            this.barManager3.DockControls.Add(this.barDockControl8);
            this.barManager3.Form = this;
            // 
            // barDockControl5
            // 
            this.barDockControl5.CausesValidation = false;
            this.barDockControl5.Dock = System.Windows.Forms.DockStyle.Top;
            this.barDockControl5.Location = new System.Drawing.Point(0, 0);
            this.barDockControl5.Manager = this.barManager3;
            this.barDockControl5.Size = new System.Drawing.Size(1122, 0);
            // 
            // barDockControl6
            // 
            this.barDockControl6.CausesValidation = false;
            this.barDockControl6.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.barDockControl6.Location = new System.Drawing.Point(0, 670);
            this.barDockControl6.Manager = this.barManager3;
            this.barDockControl6.Size = new System.Drawing.Size(1122, 0);
            // 
            // barDockControl7
            // 
            this.barDockControl7.CausesValidation = false;
            this.barDockControl7.Dock = System.Windows.Forms.DockStyle.Left;
            this.barDockControl7.Location = new System.Drawing.Point(0, 0);
            this.barDockControl7.Manager = this.barManager3;
            this.barDockControl7.Size = new System.Drawing.Size(0, 670);
            // 
            // barDockControl8
            // 
            this.barDockControl8.CausesValidation = false;
            this.barDockControl8.Dock = System.Windows.Forms.DockStyle.Right;
            this.barDockControl8.Location = new System.Drawing.Point(1122, 0);
            this.barDockControl8.Manager = this.barManager3;
            this.barDockControl8.Size = new System.Drawing.Size(0, 670);
            // 
            // bar5
            // 
            this.bar5.BarName = "Main menu";
            this.bar5.DockCol = 0;
            this.bar5.DockStyle = DevExpress.XtraBars.BarDockStyle.Top;
            this.bar5.OptionsBar.MultiLine = true;
            this.bar5.OptionsBar.UseWholeRow = true;
            this.bar5.Text = "Main menu";
            // 
            // bar2
            // 
            this.bar2.BarName = "Main menu";
            this.bar2.DockCol = 0;
            this.bar2.DockStyle = DevExpress.XtraBars.BarDockStyle.Top;
            this.bar2.OptionsBar.MultiLine = true;
            this.bar2.OptionsBar.UseWholeRow = true;
            this.bar2.Text = "Main menu";
            // 
            // barManager4
            // 
            this.barManager4.DockControls.Add(this.barDockControl9);
            this.barManager4.DockControls.Add(this.barDockControl10);
            this.barManager4.DockControls.Add(this.barDockControl11);
            this.barManager4.DockControls.Add(this.barDockControl12);
            this.barManager4.Form = this;
            // 
            // barDockControl9
            // 
            this.barDockControl9.CausesValidation = false;
            this.barDockControl9.Dock = System.Windows.Forms.DockStyle.Top;
            this.barDockControl9.Location = new System.Drawing.Point(0, 0);
            this.barDockControl9.Manager = this.barManager4;
            this.barDockControl9.Size = new System.Drawing.Size(1122, 0);
            // 
            // barDockControl10
            // 
            this.barDockControl10.CausesValidation = false;
            this.barDockControl10.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.barDockControl10.Location = new System.Drawing.Point(0, 670);
            this.barDockControl10.Manager = this.barManager4;
            this.barDockControl10.Size = new System.Drawing.Size(1122, 0);
            // 
            // barDockControl11
            // 
            this.barDockControl11.CausesValidation = false;
            this.barDockControl11.Dock = System.Windows.Forms.DockStyle.Left;
            this.barDockControl11.Location = new System.Drawing.Point(0, 0);
            this.barDockControl11.Manager = this.barManager4;
            this.barDockControl11.Size = new System.Drawing.Size(0, 670);
            // 
            // barDockControl12
            // 
            this.barDockControl12.CausesValidation = false;
            this.barDockControl12.Dock = System.Windows.Forms.DockStyle.Right;
            this.barDockControl12.Location = new System.Drawing.Point(1122, 0);
            this.barDockControl12.Manager = this.barManager4;
            this.barDockControl12.Size = new System.Drawing.Size(0, 670);
            // 
            // barManager5
            // 
            this.barManager5.DockControls.Add(this.barDockControl13);
            this.barManager5.DockControls.Add(this.barDockControl14);
            this.barManager5.DockControls.Add(this.barDockControl15);
            this.barManager5.DockControls.Add(this.barDockControl16);
            this.barManager5.Form = this;
            // 
            // barDockControl13
            // 
            this.barDockControl13.CausesValidation = false;
            this.barDockControl13.Dock = System.Windows.Forms.DockStyle.Top;
            this.barDockControl13.Location = new System.Drawing.Point(0, 0);
            this.barDockControl13.Manager = this.barManager5;
            this.barDockControl13.Size = new System.Drawing.Size(1122, 0);
            // 
            // barDockControl14
            // 
            this.barDockControl14.CausesValidation = false;
            this.barDockControl14.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.barDockControl14.Location = new System.Drawing.Point(0, 670);
            this.barDockControl14.Manager = this.barManager5;
            this.barDockControl14.Size = new System.Drawing.Size(1122, 0);
            // 
            // barDockControl15
            // 
            this.barDockControl15.CausesValidation = false;
            this.barDockControl15.Dock = System.Windows.Forms.DockStyle.Left;
            this.barDockControl15.Location = new System.Drawing.Point(0, 0);
            this.barDockControl15.Manager = this.barManager5;
            this.barDockControl15.Size = new System.Drawing.Size(0, 670);
            // 
            // barDockControl16
            // 
            this.barDockControl16.CausesValidation = false;
            this.barDockControl16.Dock = System.Windows.Forms.DockStyle.Right;
            this.barDockControl16.Location = new System.Drawing.Point(1122, 0);
            this.barDockControl16.Manager = this.barManager5;
            this.barDockControl16.Size = new System.Drawing.Size(0, 670);
            // 
            // nH_CAUHOITableAdapter
            // 
            this.nH_CAUHOITableAdapter.ClearBeforeFill = true;
            // 
            // UCQues
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.childContainer);
            this.Controls.Add(this.barDockControlLeft);
            this.Controls.Add(this.barDockControlRight);
            this.Controls.Add(this.barDockControlBottom);
            this.Controls.Add(this.barDockControlTop);
            this.Controls.Add(this.barDockControl3);
            this.Controls.Add(this.barDockControl4);
            this.Controls.Add(this.barDockControl2);
            this.Controls.Add(this.barDockControl1);
            this.Controls.Add(this.barDockControl7);
            this.Controls.Add(this.barDockControl8);
            this.Controls.Add(this.barDockControl6);
            this.Controls.Add(this.barDockControl5);
            this.Controls.Add(this.barDockControl11);
            this.Controls.Add(this.barDockControl12);
            this.Controls.Add(this.barDockControl10);
            this.Controls.Add(this.barDockControl9);
            this.Controls.Add(this.barDockControl15);
            this.Controls.Add(this.barDockControl16);
            this.Controls.Add(this.barDockControl14);
            this.Controls.Add(this.barDockControl13);
            this.Name = "UCQues";
            this.Size = new System.Drawing.Size(1122, 670);
            this.Load += new System.EventHandler(this.UCQues_Load);
            ((System.ComponentModel.ISupportInitialize)(this.repositoryItemCheckEdit1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.sP_GetAllSubOfGrade_TeacherGridControl)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.sP_GetAllSubOfGrade_TeacherBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.kiemTraHSDataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.subsTileView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.cardView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.childContainer)).EndInit();
            this.childContainer.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.quesForm)).EndInit();
            this.quesForm.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.groupControl5)).EndInit();
            this.groupControl5.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.groupControl1)).EndInit();
            this.groupControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.panelControl2)).EndInit();
            this.panelControl2.ResumeLayout(false);
            this.panelControl2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataEntryGroupControl)).EndInit();
            this.dataEntryGroupControl.ResumeLayout(false);
            this.dataEntryGroupControl.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.statusCheckEdit.Properties)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.quesBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.panelControl1)).EndInit();
            this.panelControl1.ResumeLayout(false);
            this.flowLayoutPanel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.quesGridControl)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.quesGridView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.groupControl3)).EndInit();
            this.groupControl3.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.nH_CAUHOIBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.barManager5)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private DevExpress.XtraGrid.GridControl sP_GetAllSubOfGrade_TeacherGridControl;
        private DevExpress.XtraGrid.Views.Tile.TileView subsTileView;
        private DevExpress.XtraGrid.Columns.TileViewColumn colMaMon1;
        private DevExpress.XtraGrid.Columns.TileViewColumn colTenMon1;
        private DevExpress.XtraGrid.Columns.TileViewColumn colKhoi1;
        private DevExpress.XtraGrid.Views.Card.CardView cardView1;
        private DevExpress.XtraEditors.PanelControl childContainer;
        private KiemTraHSDataSetTableAdapters.SP_GetAllSubOfGrade_TeacherTableAdapter sP_GetAllSubOfGrade_TeacherTableAdapter1;
        private KiemTraHSDataSet kiemTraHSDataSet;
        private System.Windows.Forms.BindingSource sP_GetAllSubOfGrade_TeacherBindingSource;
        private DevExpress.XtraEditors.PanelControl quesForm;
        private System.Windows.Forms.BindingSource quesBindingSource;
        private KiemTraHSDataSetTableAdapters.SP_GetAllQuesByLessonTableAdapter quesTableAdapter;
        private KiemTraHSDataSetTableAdapters.TableAdapterManager tableAdapterManager;
        private DevExpress.XtraBars.BarManager barManager1;
        private DevExpress.XtraBars.BarDockControl barDockControlTop;
        private DevExpress.XtraBars.BarDockControl barDockControlBottom;
        private DevExpress.XtraBars.BarDockControl barDockControlLeft;
        private DevExpress.XtraBars.BarDockControl barDockControlRight;
        private DevExpress.XtraBars.BarDockControl barDockControl3;
        private DevExpress.XtraBars.BarManager barManager2;
        private DevExpress.XtraBars.BarDockControl barDockControl1;
        private DevExpress.XtraBars.BarDockControl barDockControl2;
        private DevExpress.XtraBars.BarDockControl barDockControl4;
        private DevExpress.XtraBars.BarButtonItem barButtonItem1;
        private DevExpress.XtraBars.BarDockControl barDockControl7;
        private DevExpress.XtraBars.BarManager barManager3;
        private DevExpress.XtraBars.BarDockControl barDockControl5;
        private DevExpress.XtraBars.BarDockControl barDockControl6;
        private DevExpress.XtraBars.BarDockControl barDockControl8;
        private DevExpress.XtraBars.BarDockControl barDockControl11;
        private DevExpress.XtraBars.BarManager barManager4;
        private DevExpress.XtraBars.BarDockControl barDockControl9;
        private DevExpress.XtraBars.BarDockControl barDockControl10;
        private DevExpress.XtraBars.BarDockControl barDockControl12;
        private DevExpress.XtraBars.BarDockControl barDockControl15;
        private DevExpress.XtraBars.BarManager barManager5;
        private DevExpress.XtraBars.BarDockControl barDockControl13;
        private DevExpress.XtraBars.BarDockControl barDockControl14;
        private DevExpress.XtraBars.BarDockControl barDockControl16;
        private DevExpress.XtraBars.Bar bar5;
        private DevExpress.XtraBars.Bar bar2;
        private System.Windows.Forms.BindingSource nH_CAUHOIBindingSource;
        private KiemTraHSDataSetTableAdapters.NH_CAUHOITableAdapter nH_CAUHOITableAdapter;
        private DevExpress.XtraEditors.Repository.RepositoryItemCheckEdit repositoryItemCheckEdit1;
        private DevExpress.XtraEditors.GroupControl groupControl5;
        private DevExpress.XtraEditors.GroupControl groupControl1;
        private DevExpress.XtraEditors.GroupControl dataEntryGroupControl;
        private DevExpress.XtraEditors.PanelControl panelControl1;
        private DevExpress.XtraEditors.PanelControl panelControl2;
        private DevExpress.XtraEditors.LabelControl lessonLabelControl;
        private DevExpress.XtraEditors.LabelControl labelControl1;
        private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel1;
        private DevExpress.XtraEditors.SimpleButton addBtn;
        private DevExpress.XtraEditors.SimpleButton saveBtn;
        private DevExpress.XtraEditors.SimpleButton undoBtn;
        private DevExpress.XtraEditors.SimpleButton deleteBtn;
        private DevExpress.XtraEditors.SimpleButton exitBtn;
        private DevExpress.XtraGrid.GridControl quesGridControl;
        private DevExpress.XtraGrid.Views.Grid.GridView quesGridView;
        private DevExpress.XtraGrid.Columns.GridColumn colNoiDung;
        private DevExpress.XtraGrid.Columns.GridColumn colA;
        private DevExpress.XtraGrid.Columns.GridColumn colB;
        private DevExpress.XtraGrid.Columns.GridColumn colC;
        private DevExpress.XtraGrid.Columns.GridColumn colD;
        private DevExpress.XtraGrid.Columns.GridColumn colDapAn;
        private DevExpress.XtraGrid.Columns.GridColumn colTrangThai;
        private DevExpress.XtraEditors.GroupControl groupControl3;
        private System.Windows.Forms.TreeView treeViewLessons;
        private DevExpress.XtraEditors.CheckEdit statusCheckEdit;
        private System.Windows.Forms.ComboBox ansComboBox;
        private System.Windows.Forms.RichTextBox dOptionRichTextBox;
        private System.Windows.Forms.RichTextBox cOptionRichTextBox;
        private System.Windows.Forms.RichTextBox bOptionRichTextBox;
        private System.Windows.Forms.RichTextBox aOptionRichTextBox;
        private System.Windows.Forms.RichTextBox contentRichTextBox;
        private DevExpress.XtraEditors.SimpleButton editBtn;
    }
}
