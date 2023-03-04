import { IsString, IsNotEmpty, IsInt, IsArray } from 'class-validator';

export class PurchaseBillDto {
  @IsInt()
  @IsNotEmpty()
  draw_id: number;

  @IsArray()
  @IsNotEmpty()
  tickets: Array<TicketsDto>;

  @IsString()
  @IsNotEmpty()
  p_date: string;
}

export class TicketsDto {
  @IsString()
  @IsNotEmpty()
  type: string;

  @IsString()
  @IsNotEmpty()
  number: string;

  @IsString()
  @IsNotEmpty()
  count: string;

  @IsString()
  customer: string;
}
