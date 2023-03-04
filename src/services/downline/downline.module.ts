import { Module } from '@nestjs/common';
import { DownlineService } from './downline.service';
import { DownlineController } from './downline.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  controllers: [DownlineController],
  imports: [DatabaseModule],
  providers: [DownlineService],
})
export class DownlineModule {}
