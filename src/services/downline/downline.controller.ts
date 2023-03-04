import { Body, Controller, Post, Req, UseGuards } from '@nestjs/common';
import { DownlineService } from './downline.service';
import { DownlineDto } from './dto/downline.dto';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';

@ApiBearerAuth()
@ApiTags('downline')
@UseGuards(JwtAuthGuard)
@Controller('downline')
export class DownlineController {
  constructor(private readonly downlineService: DownlineService) {}

  @Post()
  GetDownline(@Body() body: DownlineDto, @Req() req) {
    return this.downlineService.GetDownline(body, req.sessionpayload);
  }
}
