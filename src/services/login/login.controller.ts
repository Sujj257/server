import { Controller, Post, Body } from '@nestjs/common';
import { LoginService } from './login.service';
import { LoginDto } from './dto/login.dto';
import { ApiTags } from '@nestjs/swagger';
import { UserCheckerDto } from './dto/userchecker.dto';

@ApiTags('login')
@Controller('login')
export class LoginController {
  constructor(private readonly loginService: LoginService) { }

  @Post()
  login(@Body() body: LoginDto) {
    return this.loginService.checkuser(body);
  }

  @Post('check')
  checker(@Body() body: UserCheckerDto) {
    return this.loginService.checker(body);
  }

}
