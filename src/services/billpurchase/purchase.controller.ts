import { Body, Controller, Post, Req, UseGuards } from '@nestjs/common';
import { purchaseService } from './purchase.service';
import { PurchaseDeleteDto } from './dto/deletebill.dto';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { PurchaseBillDto } from './dto/createbill.dto';
@UseGuards(JwtAuthGuard)
@Controller('purchase')
export class purchaseController {
  constructor(private readonly billpurchaseService: purchaseService) {}

  @Post('delete')
  PurchaseDelete(@Body() body: PurchaseDeleteDto, @Req() req) {
    return this.billpurchaseService.purchaseDelete(body, req.sessionpayload);
  }

  @Post('create')
  CreatePurchase(@Body() body: PurchaseBillDto, @Req() req) {
    return this.billpurchaseService.CreatePurchase(body, req.sessionpayload);
  }
}
