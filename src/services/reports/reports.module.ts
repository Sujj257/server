import { Module } from '@nestjs/common';
import { ReportsService } from './reports.service';
import { ReportsController } from './reports.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  controllers: [ReportsController],
  imports: [DatabaseModule],
  providers: [ReportsService],
})
export class ReportsModule {}
