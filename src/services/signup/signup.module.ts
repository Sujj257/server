import { Module } from '@nestjs/common';
import { SignupService } from './signup.service';
import { SignupController } from './signup.controller';
import { DatabaseModule } from '../database/database.module';
import { AuthModule } from '../auth/auth.module';

@Module({
  providers: [SignupService],
  imports: [DatabaseModule],
  controllers: [SignupController],
})
export class bSignupModule {}
