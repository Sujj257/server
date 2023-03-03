
import { IsString, IsNotEmpty, IsInt, IsBoolean, IsOptional, isNotEmpty } from 'class-validator';

export class PurchaseReportDto {

    @IsString() @IsNotEmpty()
    account_id: string;
 
    @IsString()  @IsNotEmpty()
    from_date: string ;

    @IsString()  @IsNotEmpty()
    to_date: string;

    @IsString()  @IsNotEmpty()
    draw_id: string;

    @IsBoolean()  @IsNotEmpty()
    getalldata: boolean;

    @IsString()
    filter: string;

    @IsBoolean()  @IsNotEmpty()
    agent_rate: boolean;
}