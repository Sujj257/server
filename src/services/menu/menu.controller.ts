import { Body, Controller, Post, Req, UseGuards } from '@nestjs/common';
import { MenuService } from './menu.service';
import { MenuDto } from './dto/menu.dto';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@UseGuards(JwtAuthGuard)
@Controller('menu')
export class MenuController {
  constructor(private readonly menuService: MenuService) {}

  @Post()
  getMenu(@Body() body: MenuDto, @Req() req) {
    return this.menuService.GetMenu(body, req.sessionpayload);
  }
}
