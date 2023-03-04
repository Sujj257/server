import { Body, Controller, Post, Req, UseGuards } from '@nestjs/common';
import { WinningService } from './winning.service';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { WinningDetailViewDto } from './dto/winninghistorydetail.dto';
import { WinningResultViewDto } from './dto/resultview.dto';
import { WinningPrizeUpdateDto } from './dto/winningprizeupdate.dto';
import { WinningCommissionDto } from './dto/winningcommission.dto';
import { WinningExecuteDto } from './dto/winningexecute.dto';

@UseGuards(JwtAuthGuard)
@Controller('winning')
export class WinningController {
  constructor(private readonly winningService: WinningService) {}

  @Post('execute')
  WinningExecute(@Body() body: WinningExecuteDto, @Req() req) {
    return this.winningService.WinningExecute(body, req.sessionpayload);
  }

  @Post('detailview')
  WinningDetailView(@Body() body: WinningDetailViewDto, @Req() req) {
    return this.winningService.WinningDetailView(body, req.sessionpayload);
  }

  @Post('resultview')
  ResultView(@Body() body: WinningResultViewDto, @Req() req) {
    return this.winningService.ResultView(body, req.sessionpayload);
  }

  @Post('prize/update')
  WinningPrizeUpdate(@Body() body: WinningPrizeUpdateDto, @Req() req) {
    return this.winningService.WinningPrizeUpdate(body, req.sessionpayload);
  }

  @Post('commission/update')
  WinningCommissionUpdate(@Body() body: WinningCommissionDto, @Req() req) {
    return this.winningService.WinningCommissionUpdate(
      body,
      req.sessionpayload,
    );
  }
}
