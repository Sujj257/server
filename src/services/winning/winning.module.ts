import { Module } from '@nestjs/common';
import { WinningService } from './winning.service';
import { WinningController } from './winning.controller';

@Module({
  controllers: [WinningController],
  providers: [WinningService],
})
export class WinningModule {}
