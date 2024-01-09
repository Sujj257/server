import { Body, Controller, Post, Req, UseGuards } from '@nestjs/common';
import { ReportsService } from './reports.service';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { PurchaseReportDto } from './dto/purchasereport.dto';
import { TopCountReportDto } from './dto/topcountreport.dto';
import { TotalCountReportDto } from './dto/totalcountreport.dto';
import { WinningReportDto } from './dto/winningreport.dto';
import { DailyReportDto } from './dto/dailyreport.dto';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { AdminCountReportDto } from './dto/admincountreport.dto';

@ApiBearerAuth()
@ApiTags('reports')
@UseGuards(JwtAuthGuard)
@Controller('reports')
export class ReportsController {
  constructor(private readonly reportsService: ReportsService) {}

  @Post('topcount')
  TopCountReport(@Body() body: TopCountReportDto, @Req() req) {
    return this.reportsService.TopCountReport(body, req.sessionpayload);
  }

  @Post('purchase')
  PurchaseReport(@Body() body: PurchaseReportDto, @Req() req) {
    return this.reportsService.purchaseReport(body, req.sessionpayload);
  }

  @Post('totalcount')
  TotalCountReport(@Body() body: TotalCountReportDto, @Req() req) {
    return this.reportsService.TotalCountReport(body, req.sessionpayload);
  }

  @Post('winning')
  WinningReport(@Body() body: WinningReportDto, @Req() req) {
    return this.reportsService.WinningReport(body, req.sessionpayload);
  }

  @Post('daily')
  DailyReport(@Body() body: DailyReportDto, @Req() req) {
    return this.reportsService.DailyReport(body, req.sessionpayload);
  }
  @Post('admincount')
  adminCountReport(@Body() body: AdminCountReportDto, @Req() req) {
    return this.reportsService.adminCountReport(body, req.sessionpayload);
  }
}
