import { Module } from '@nestjs/common';
import { ProfileService } from './profile.service';
import { ProfileController } from './profile.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  controllers: [ProfileController],
  imports: [DatabaseModule],
  providers: [ProfileService],
})
export class ProfileModule {}
