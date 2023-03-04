import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class WinningResultViewDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'from_date',
    example: '2023-01-01',
  })
  from_date: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'to_date',
    example: '2023-01-01',
  })
  to_date: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'draw_id',
    example: '1',
  })
  draw_id: string;
}
