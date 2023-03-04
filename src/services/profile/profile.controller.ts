import { Body, Controller, Post, Req, UseGuards } from '@nestjs/common';
import { ProfileService } from './profile.service';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { FetchProfileDto } from './dto/getprofile.dto';
import { UpdateProfileDto } from './dto/updateprofile.dto';

@UseGuards(JwtAuthGuard)
@Controller('profile')
export class ProfileController {
  constructor(private readonly profileService: ProfileService) {}

  @Post('fetch')
  FetchProfile(@Body() body: FetchProfileDto, @Req() req) {
    return this.profileService.FetchProfile(body, req.sessionpayload);
  }

  @Post('update')
  UpdateProfile(@Body() body: UpdateProfileDto, @Req() req) {
    return this.profileService.UpdateProfile(body, req.sessionpayload);
  }
}
