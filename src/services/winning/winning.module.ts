import { Module } from '@nestjs/common';
import { WinningService } from './winning.service';
import { WinningController } from './winning.controller';
import { DatabaseModule } from '../database/database.module';

@Module({
  controllers: [WinningController],
  imports: [DatabaseModule],
  providers: [WinningService],
})
export class WinningModule {}
