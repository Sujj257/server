import { Body, Controller, Post, Req } from '@nestjs/common';
import { purchaseService } from './purchase.service';
import { PurchaseReportDto } from './dto/purchasereport.dto';

@Controller('purchase')
export class purchaseController {
  constructor(private readonly billpurchaseService: purchaseService) {}

  @Post('report')
  PurchaseReport(@Body() body: PurchaseReportDto, @Req() req) {
    return this.billpurchaseService.purchaseReport(body, req.sessionpayload);
  }
}
