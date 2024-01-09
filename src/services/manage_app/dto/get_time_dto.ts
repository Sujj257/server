import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsBoolean } from 'class-validator';

export class TimeDto {

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
        description: 'eventname',
        example: 'draw_end',
    })
    eventname: string;

    @IsString()
    @IsNotEmpty()
    @ApiProperty({
        description: 'eventtime',
        example: '13:00:00',
    })
    eventtime: string;

    @IsBoolean()
    @IsNotEmpty()
    @ApiProperty({
        description: 'isedit',
        example: true,
    })
    isedit = true;

}
