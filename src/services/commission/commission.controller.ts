import { Body, Controller, Post, Req, UseGuards } from '@nestjs/common';
import { CommissionService } from './commission.service';
import { FetchCommissionDto } from './dto/fetchcommission.dto';
import { UpdateCommissionDto } from './dto/updatecommission.dto';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';

@ApiBearerAuth()
@ApiTags('commission')
@UseGuards(JwtAuthGuard)
@Controller('commission')
export class CommissionController {
  constructor(private readonly commissionService: CommissionService) {}

  @Post('fetch')
  FetchCommission(@Body() body: FetchCommissionDto, @Req() req) {
    return this.commissionService.FetchCommission(body, req.sessionpayload);
  }

  @Post('update')
  UpdateCommmission(@Body() body: UpdateCommissionDto, @Req() req) {
    return this.commissionService.UpdateCommmission(body, req.sessionpayload);
  }
}
