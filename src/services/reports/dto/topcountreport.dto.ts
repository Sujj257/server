import { IsString, IsNotEmpty, IsBoolean } from 'class-validator';

export class TopCountReportDto {
  @IsString()
  @IsNotEmpty()
  account_id: string;

  @IsString()
  @IsNotEmpty()
  from_date: string;

  @IsString()
  @IsNotEmpty()
  to_date: string;

  @IsString()
  @IsNotEmpty()
  draw_id: string;

  @IsBoolean()
  @IsNotEmpty()
  getalldata: boolean;

  @IsString()
  filter: string;
}