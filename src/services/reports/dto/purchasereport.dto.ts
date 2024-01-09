import { IsString, IsNotEmpty, IsBoolean, IsNumber } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class PurchaseReportDto {
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
    example: '2023-01-01',
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

  @IsString()
  @ApiPropertyOptional({
    description: 'filter',
    example: 'null',
  })
  filter: string;

  @IsBoolean()
  @IsNotEmpty()
  @ApiProperty({
    description: 'agent_rate',
    example: false,
  })
  agent_rate: boolean;

  @IsNumber()
  @IsNotEmpty()
  @ApiProperty({
    description: 'Page_No',
    example: 1,
  })
  page_no: number;

  @IsNumber()
  @IsNotEmpty()
  @ApiProperty({
    description: 'row_per_page',
    example: 10,
  })
  row_per_page: number;
}
