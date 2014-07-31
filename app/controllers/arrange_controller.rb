class ArrangeController < ApplicationController
  require 'rubygems'
  require 'roo'
  require 'fileutils'
  Mime::Type.register "application/xls", :xls

  def index
  end


  def add_a_new_xlsx
    if !params[:add_a_new_xlsx]
      flash[:error]="请选择文件"
      render 'index'
      return
    end
    file = params[:add_a_new_xlsx][:excel_sheet]
    excel = Excel.create({:excel => file})
    excel_type = File.extname(excel.excel.path)
    if excel_type == ".xlsx"
      sheet = Roo::Excelx.new(excel.excel.path)
    end
    if excel_type == ".xls"
      sheet = Roo::Excel.new(excel.excel.path)
    end
    if excel_type != ".xlsx"&&excel_type != ".xls"
      flash[:error]="请选择.xls 或.xlxs格式文件"
      render 'index'
      return
    end

    sheet1_last_row=sheet.last_row
    sheet2_last_row=sheet.last_row(sheet.sheets[1])

    Excle1.delete_all
    Excle2.delete_all
    ExcleDate.delete_all
    excle1_date={:name => sheet.cell(1, 2), :number => sheet.cell(1, 1), :status => sheet.cell(1, 3)}
    excle_date=ExcleDate.new(excle1_date)
    excle_date.save
    excle1_date={:name => sheet.cell(1, 2, sheet.sheets[1]), :number => sheet.cell(1, 1, sheet.sheets[1]), :status => sheet.cell(1, 3, sheet.sheets[1])}
    excle_date=ExcleDate.new(excle1_date)
    excle_date.save
    $i = 3
    $num = sheet1_last_row
    Excle1.transaction do
      begin
        date={:a_date => sheet.cell($i, 1), :b_opening => sheet.cell($i, 2), :c_max => sheet.cell($i, 3), :d_min => sheet.cell($i, 4),
              :e_close => sheet.cell($i, 5), :f_volume => sheet.cell($i, 6),
              :g_turnover => sheet.cell($i, 7), :h_traded_items => sheet.cell($i, 8),
              :i_ma1 => sheet.cell($i, 9), :j_ma2 => sheet.cell($i, 10),
              :k_ma3 => sheet.cell($i, 11), :l_ma4 => sheet.cell($i, 12),
              :m_ma5 => sheet.cell($i, 13), :n_ma6 => sheet.cell($i, 14)}
        excle1=Excle1.new(date)
        excle1.save
        $i +=1
      end while $i < $num
    end

    $i = 3
    $num = sheet2_last_row
    Excle2.transaction do
      begin
        date={:a_date => sheet.cell($i, 1, sheet.sheets[1]), :b_opening => sheet.cell($i, 2, sheet.sheets[1]), :c_max => sheet.cell($i, 3, sheet.sheets[1]), :d_min => sheet.cell($i, 4, sheet.sheets[1]),
              :e_close => sheet.cell($i, 5, sheet.sheets[1]), :f_volume => sheet.cell($i, 6, sheet.sheets[1]),
              :g_turnover => sheet.cell($i, 7, sheet.sheets[1]), :h_traded_items => sheet.cell($i, 8, sheet.sheets[1]),
              :i_ma1 => sheet.cell($i, 9, sheet.sheets[1]), :j_ma2 => sheet.cell($i, 10, sheet.sheets[1]),
              :k_ma3 => sheet.cell($i, 11, sheet.sheets[1]), :l_ma4 => sheet.cell($i, 12, sheet.sheets[1]),
              :m_ma5 => sheet.cell($i, 13, sheet.sheets[1]), :n_ma6 => sheet.cell($i, 14, sheet.sheets[1])}
        excle2=Excle2.new(date)
        excle2.save
        $i +=1
      end while $i < $num
    end
    render "index"
  end


  def delete
    @excle1=Excle1.all.sort_by { |x| x.a_date }
    @excle2=Excle2.all.sort_by { |x| x.a_date }
    @excle1_date=@excle1[0]
    @excle2_date=@excle2[0]
    if @excle1[0].a_date>@excle2[0].a_date
      $num=0
      @excle1_date=@excle1[0]
      begin
        @excle2_date=Excle2.find_by(:id => @excle2[$num].id)
        Excle2.find_by(:id => @excle2[$num].id).delete
        $num=$num+1;
      end while @excle1[0].a_date>@excle2[$num].a_date
    end
    if @excle1[0].a_date<@excle2[0].a_date
      $num=0
      @excle2_date=@excle2[0]
      begin
        @excle1_date=Excle1.find_by(:id => @excle1[$num].id)
        Excle1.find_by("a_date" => @excle1[$num].a_date).delete
        $num=$num+1;
      end while @excle2[0].a_date>@excle1[$num].a_date
    end
    add(@excle1_date, @excle2_date)
  end


  def add(excle1_date, excle2_date)

    excle1_start_time=Excle1.all.sort_by { |x| x.a_date }[0].a_date;
    excle2_start_time=Excle2.all.sort_by { |x| x.a_date }[0].a_date;
    start_time=excle1_start_time>=excle2_start_time ? excle2_start_time : excle1_start_time;
    excle1_end_time=Excle1.all.sort_by { |x| x.a_date }[Excle1.all.length-1].a_date;
    excle2_end_time=Excle2.all.sort_by { |x| x.a_date }[Excle2.all.length-1].a_date;

    excle1_date=Excle1.all.sort_by { |x| x.a_date }[0]
    excle2_date=Excle2.all.sort_by { |x| x.a_date }[0]

    begin

      if Excle1.find_by(:a_date => start_time) && Excle2.find_by(:a_date => start_time)
        excle1_date=Excle1.find_by(:a_date => start_time)
        excle2_date=Excle2.find_by(:a_date => start_time)
      end

      if Excle1.find_by(:a_date => start_time) && !Excle2.find_by(:a_date => start_time)
        excle1_date=Excle1.find_by(:a_date => start_time)
        date={:a_date => start_time, :b_opening => excle2_date.b_opening, :c_max => excle2_date.c_max, :d_min => excle2_date.d_min,
              :e_close => excle2_date.e_close, :f_volume => excle2_date.f_volume,
              :g_turnover => excle2_date.g_turnover, :h_traded_items => excle2_date.h_traded_items,
              :i_ma1 => excle2_date.i_ma1, :j_ma2 => excle2_date.j_ma2,
              :k_ma3 => excle2_date.k_ma3, :l_ma4 => excle2_date.l_ma4,
              :m_ma5 => excle2_date.m_ma5, :n_ma6 => excle2_date.n_ma6}
        new_date=Excle2.new(date)
        new_date.save
      end

      if !Excle1.find_by(:a_date => start_time) && Excle2.find_by(:a_date => start_time)
        excle2_date=Excle2.find_by(:a_date => start_time)
        date={:a_date => start_time, :b_opening => excle1_date.b_opening, :c_max => excle1_date.c_max, :d_min => excle1_date.d_min,
              :e_close => excle1_date.e_close, :f_volume => excle1_date.f_volume,
              :g_turnover => excle1_date.g_turnover, :h_traded_items => excle1_date.h_traded_items,
              :i_ma1 => excle1_date.i_ma1, :j_ma2 => excle1_date.j_ma2,
              :k_ma3 => excle1_date.k_ma3, :l_ma4 => excle1_date.l_ma4,
              :m_ma5 => excle1_date.m_ma5, :n_ma6 => excle1_date.n_ma6}
        new_date=Excle1.new(date)
        new_date.save
      end
      start_time=start_time+1
    end while excle1_end_time>=start_time||excle2_end_time>=start_time
    render 'index'
  end

  respond_to :html, :xls

  def daochu
    @excle1_date=Excle1.all.sort_by { |x| x.a_date }
    for i in 0..@excle1_date.length-1
      i=i.to_int
      @excle1_date[i].a_date= @excle1_date[i]["a_date"].to_s[0..9].to_s
    end
    excle1_name=ExcleDate.first.name
    respond_to do |format|
      format.xls { send_data @excle1_date.to_xls(:headers => ['日期', '开盘', '最高', '最低', '收盘', '成交量', '成交额', '成交笔数', 'MA1', 'MA2', 'MA3', 'MA4', 'MA5', 'MA6']), :filename => excle1_name+'.xls' }
    end
  end

  def daochu_excle2

    @excle2_date=Excle2.all.sort_by { |x| x.a_date }
    for i in 0..@excle2_date.length-1
      i=i.to_int
      @excle2_date[i]["a_date"]= @excle2_date[i]["a_date"].to_s[0..9].to_s

    end
    excle2_name=ExcleDate.last.name
    respond_to do |format|
      format.xls { send_data @excle2_date.to_xls(:headers => ['日期', '开盘', '最高', '最低', '收盘', '成交量', '成交额', '成交笔数', 'MA1', 'MA2', 'MA3', 'MA4', 'MA5', 'MA6']), :filename => excle2_name+".xls" }
    end
  end

  def show_excle
    @excle_date=ExcleDate.first
    @excle1_date_list=Excle1.all.sort_by { |x| x.a_date }
    # @excle1_date_list=Excle1.paginate(page: params[:page], per_page: 10).all.sort_by { |x|x.a_date}
  end

  def show_excle2
    @excle_date=ExcleDate.last
    @excle2_date_list=Excle2.all.sort_by { |x| x.a_date }
    # @excle2_date_list=Excle2.paginate(page: params[:page], per_page: 10).all.sort_by { |x|x.a_date}
  end
end

