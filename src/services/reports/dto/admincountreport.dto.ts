import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsBoolean } from 'class-validator';

export class AdminCountReportDto {
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
    description: 'from_date',
    example: 'null',
  })
  from_date: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'to_date',
    example: '2023-01-03',
  })
  to_date: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty({
    description: 'draw_id',
    example: '1',
  })
  draw_id: string;

  @IsBoolean()
  @IsNotEmpty()
  @ApiProperty({
    description: 'getalldata',
    example: true,
  })
  getalldata: boolean;
}
