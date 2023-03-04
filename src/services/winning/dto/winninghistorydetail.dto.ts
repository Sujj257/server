import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class WinningDetailViewDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'account_id',
    example: 'null',
  })
  account_id: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'p_date',
    example: '2023-01-01',
  })
  p_date: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'draw_id',
    example: '1',
  })
  draw_id: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'ticket_type',
    example: 'DEAR',
  })
  ticket_type: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'ticket_type',
    example: '345',
  })
  number: string;
}
