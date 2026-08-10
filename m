Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F822DB791;
	Mon, 10 Aug 2026 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376039; cv=none; b=Laj6YiY+6xU9uzep4mhhLFrlill9uKkuBVn3kX6UALnQj0IHezRRmd5v8qQgqIknpF1N6pXZX3OWk+YJbR8bBPqF3qvtnyxJEK3xUPsLlYHS9xIDGGyvBz1SGqwqerld37weewROK48T6a8cYs6ySLKIuZj0BFqxsSoBdrkuRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376039; c=relaxed/simple;
	bh=EEATQDQ8pREIbAruiprLI26JXyVIyV66kZ0na7XIeJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL+T2b6Kd7/cAK/91S7JH4exL2sL4ojGxh5SblQqRZcxCvORwkGRUEJnRzzyVwyyC1Olnou7N+pfmzYQ4gs+gHNjgtvby/lWhcw8usTWuPGdRzSeg23l2qFkYrx7IInr8VuIz3Y4iVXFqHlbQWEEtuEEncSEzN03rs/sAWXVBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljU0QfJM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljU0QfJM"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 143A01F00A3E;
	Mon, 10 Aug 2026 15:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786376032;
	bh=FUUSkEWxe7s+jykgrn9yyD7/QA0Hb+8ydfj7a9ksnJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ljU0QfJM/eoSWNVQ1Ddx+WhNN4h4sDls0+yI+N8XOssRqmrZl9Ek8oFuuKZHUVhvK
	 4U2U8+UxKc+pl2QCbQgcLwtf7fkXF369zyNNjlXtfbxTkaZdjC0geESIDx3f5Yqs9Y
	 lvN2NwCFwHYgvvUtwKADGEIYRCwDIuQbEjIgZ/7lt0OlxD8nNT71CDGvNoWvbLZezd
	 Vv9DI6vhJKcOyMozbMvc9I4AFEMITWXTsByC09738uNmn9m7Py1eQ9VgvxWzAcBK+6
	 ert45U5bcSX74LXrPlq1QIdW7Nr1aQkcoXFzNrezvhyidOIuGjLsib5f6nD/yhMC3e
	 Nhka9KReMnHww==
Date: Mon, 10 Aug 2026 18:33:49 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Julien <julien82453@gmail.com>
Cc: linux-integrity@vger.kernel.org, regressions@lists.linux.dev,
	rafael.j.wysocki@intel.com
Subject: Re: [REGRESSION] no TPM device after "tpm_crb: Convert ACPI driver
 to a platform one"
Message-ID: <annvXXwcLfD2NQDU@kernel.org>
References: <CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com>

On Sun, Aug 02, 2026 at 02:54:47PM +0200, Julien wrote:
> Hello,
> 
> Please keep in mind this is my first time reporting a Linux kernel regression.
> 
> Since commit 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platform one"),
> my TPM device is no longer available. Both /dev/tpm0 and /dev/tpmrm0 are
> missing.
> 
> Log messages:
> platform MSFT0101:00: failed to claim resource 1: [mem 0xfed40000-0xfed40fff]
> acpi MSFT0101:00: platform device creation failed: -16
> 
> I added some debug logging:
> ACPI resourcet[0] = [mem 0xfed40040-0xfed4103f flags 0x200]
> ACPI resourcet[1] = [mem 0xfed40000-0xfed40fff flags 0x200]
> 
> I think the failure happens in kernel/resource.c: __insert_resource() because
> of the two memory regions overlapping.
> 
> I am attaching the TPM SSDT and the SDDT defining PTTB ACPI variable address.
> The value of PPTB
> dd if=/dev/mem bs=1 skip=$((0x8AE5CFDC)) count=8 | hexdump -C
> 40 00 d4 fe 00 00 00 00
> 
> Hardware information:
>   Manufacturer: Acer
>   Model: Aspire ES1-572
>   BIOS vendor: Insyde Corp.
>   BIOS version: V1.16
>   BIOS date: 09/18/2018
> 
> Thanks
> 
> #regzbot introduced: 48fe2cddc85c
> 

> /*
>  * Intel ACPI Component Architecture
>  * AML/ASL+ Disassembler version 20251212 (64-bit version)
>  * Copyright (c) 2000 - 2025 Intel Corporation
>  * 
>  * Disassembling to symbolic ASL+ operators
>  *
>  * Disassembly of ssdt10.dat
>  *
>  * Original Table Header:
>  *     Signature        "SSDT"
>  *     Length           0x000004C8 (1224)
>  *     Revision         0x02
>  *     Checksum         0x69
>  *     OEM ID           "ACRSYS"
>  *     OEM Table ID     "ACRPRDCT"
>  *     OEM Revision     0x00001000 (4096)
>  *     Compiler ID      "1025"
>  *     Compiler Version 0x00040000 (262144)
>  */
> DefinitionBlock ("", "SSDT", 2, "ACRSYS", "ACRPRDCT", 0x00001000)
> {
>     External (PTTB, UnknownObj)
> 
>     Scope (\_SB)
>     {
>         Device (TPM)
>         {
>             Name (_HID, "MSFT0101" /* TPM 2.0 Security Device */)  // _HID: Hardware ID
>             Name (_STR, Unicode ("TPM 2.0 Device"))  // _STR: Description String
>             Name (CRS, ResourceTemplate ()
>             {
>                 Memory32Fixed (ReadOnly,
>                     0x00000000,         // Address Base
>                     0x00001000,         // Address Length
>                     _Y00)
>                 Memory32Fixed (ReadOnly,
>                     0xFED40000,         // Address Base
>                     0x00001000,         // Address Length
>                     )
>             })
>             Name (PTTA, 0xFED40000)
>             Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
>             {
>                 CreateDWordField (CRS, \_SB.TPM._Y00._BAS, CBAS)  // _BAS: Base Address
>                 CBAS = PTTB /* External reference */
>                 PTTA = PTTB /* External reference */
>                 Return (CRS) /* \_SB_.TPM_.CRS_ */
>             }
> 
>             OperationRegion (SMIP, SystemIO, 0xB2, One)
>             Field (SMIP, ByteAcc, NoLock, Preserve)
>             {
>                 IOB2,   8
>             }
> 
>             OperationRegion (TPMR, SystemMemory, PTTA, 0x1000)
>             Field (TPMR, AnyAcc, NoLock, Preserve)
>             {
>                 Offset (0x44), 
>                 FERR,   32, 
>                 Offset (0x4C), 
>                 STRT,   32
>             }
> 
>             OperationRegion (FHCI, SystemMemory, 0xFED40000, 0x1000)
>             Field (FHCI, AnyAcc, NoLock, Preserve)
>             {
>                 Offset (0x04), 
>                 HERR,   32, 
>                 Offset (0x40), 
>                 CREQ,   32, 
>                 CSTS,   32, 
>                 Offset (0x4C), 
>                 HCMD,   32
>             }
> 
>             OperationRegion (TNVS, SystemMemory, 0x8AE4F000, 0x2B)
>             Field (TNVS, AnyAcc, NoLock, Preserve)
>             {
>                 PPIN,   8, 
>                 PPIP,   32, 
>                 PPRP,   32, 
>                 PPRQ,   32, 
>                 PPRM,   32, 
>                 LPPR,   32, 
>                 FRET,   32, 
>                 MCIN,   8, 
>                 MCIP,   32, 
>                 MORD,   32, 
>                 MRET,   32
>             }
> 
>             Method (PTS, 1, Serialized)
>             {
>                 If (((Arg0 < 0x06) && (Arg0 > 0x03)))
>                 {
>                     If (!(MORD & 0x10))
>                     {
>                         MCIP = 0x02
>                         IOB2 = MCIN /* \_SB_.TPM_.MCIN */
>                     }
>                 }
> 
>                 Return (Zero)
>             }
> 
>             Method (_STA, 0, NotSerialized)  // _STA: Status
>             {
>                 Return (0x0F)
>             }
> 
>             Method (HINF, 3, Serialized)
>             {
>                 Switch (ToInteger (Arg1))
>                 {
>                     Case (Zero)
>                     {
>                         Return (Buffer (One)
>                         {
>                              0x03                                             // .
>                         })
>                     }
>                     Case (One)
>                     {
>                         Name (TPMV, Package (0x02)
>                         {
>                             One, 
>                             Package (0x02)
>                             {
>                                 One, 
>                                 0x20
>                             }
>                         })
>                         If ((_STA () == Zero))
>                         {
>                             Return (Package (0x01)
>                             {
>                                 Zero
>                             })
>                         }
> 
>                         Return (TPMV) /* \_SB_.TPM_.HINF.TPMV */
>                     }
>                     Default
>                     {
>                         BreakPoint
>                     }
> 
>                 }
> 
>                 Return (Buffer (One)
>                 {
>                      0x00                                             // .
>                 })
>             }
> 
>             Name (TPM2, Package (0x02)
>             {
>                 Zero, 
>                 Zero
>             })
>             Name (TPM3, Package (0x03)
>             {
>                 Zero, 
>                 Zero, 
>                 Zero
>             })
>             Method (TPPI, 3, Serialized)
>             {
>                 Switch (ToInteger (Arg1))
>                 {
>                     Case (Zero)
>                     {
>                         Return (Buffer (0x02)
>                         {
>                              0xFF, 0x01                                       // ..
>                         })
>                     }
>                     Case (One)
>                     {
>                         Return ("1.2")
>                     }
>                     Case (0x02)
>                     {
>                         PPRQ = DerefOf (Arg2 [Zero])
>                         PPIP = 0x02
>                         IOB2 = PPIN /* \_SB_.TPM_.PPIN */
>                         Return (FRET) /* \_SB_.TPM_.FRET */
>                     }
>                     Case (0x03)
>                     {
>                         TPM2 [One] = PPRQ /* \_SB_.TPM_.PPRQ */
>                         Return (TPM2) /* \_SB_.TPM_.TPM2 */
>                     }
>                     Case (0x04)
>                     {
>                         Return (0x02)
>                     }
>                     Case (0x05)
>                     {
>                         PPIP = 0x05
>                         IOB2 = PPIN /* \_SB_.TPM_.PPIN */
>                         TPM3 [One] = LPPR /* \_SB_.TPM_.LPPR */
>                         TPM3 [0x02] = PPRP /* \_SB_.TPM_.PPRP */
>                         Return (TPM3) /* \_SB_.TPM_.TPM3 */
>                     }
>                     Case (0x06)
>                     {
>                         Return (0x03)
>                     }
>                     Case (0x07)
>                     {
>                         PPIP = 0x07
>                         PPRQ = DerefOf (Arg2 [Zero])
>                         PPRM = Zero
>                         If ((PPRQ == 0x17))
>                         {
>                             PPRM = DerefOf (Arg2 [One])
>                         }
> 
>                         IOB2 = PPIN /* \_SB_.TPM_.PPIN */
>                         Return (FRET) /* \_SB_.TPM_.FRET */
>                     }
>                     Case (0x08)
>                     {
>                         PPIP = 0x08
>                         PPRQ = DerefOf (Arg2 [Zero])
>                         IOB2 = PPIN /* \_SB_.TPM_.PPIN */
>                         Return (FRET) /* \_SB_.TPM_.FRET */
>                     }
>                     Default
>                     {
>                         BreakPoint
>                     }
> 
>                 }
> 
>                 Return (One)
>             }
> 
>             Method (TMCI, 3, Serialized)
>             {
>                 Switch (ToInteger (Arg1))
>                 {
>                     Case (Zero)
>                     {
>                         Return (Buffer (One)
>                         {
>                              0x03                                             // .
>                         })
>                     }
>                     Case (One)
>                     {
>                         MORD = DerefOf (Arg2 [Zero])
>                         MCIP = One
>                         IOB2 = MCIN /* \_SB_.TPM_.MCIN */
>                         Return (MRET) /* \_SB_.TPM_.MRET */
>                     }
>                     Default
>                     {
>                         BreakPoint
>                     }
> 
>                 }
> 
>                 Return (One)
>             }
> 
>             Method (TSMI, 3, Serialized)
>             {
>                 Name (WTME, Zero)
>                 Switch (ToInteger (Arg1))
>                 {
>                     Case (Zero)
>                     {
>                         Return (Buffer (One)
>                         {
>                              0x03                                             // .
>                         })
>                     }
>                     Case (One)
>                     {
>                         CREQ = One
>                         While (((WTME <= 0xC8) && ((CREQ & One) != 
>                             Zero)))
>                         {
>                             Sleep (One)
>                             WTME++
>                         }
> 
>                         HCMD = 0x02
>                         Return (Zero)
>                     }
>                     Default
>                     {
>                         BreakPoint
>                     }
> 
>                 }
> 
>                 Return (One)
>             }
> 
>             Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
>             {
>                 If ((Arg0 == ToUUID ("cf8e16a5-c1e8-4e25-b712-4f54a96702c8") /* TPM Hardware Information */))
>                 {
>                     Return (HINF (Arg1, Arg2, Arg3))
>                 }
> 
>                 If ((Arg0 == ToUUID ("3dddfaa6-361b-4eb4-a424-8d10089d1653") /* Physical Presence Interface */))
>                 {
>                     Return (TPPI (Arg1, Arg2, Arg3))
>                 }
> 
>                 If ((Arg0 == ToUUID ("376054ed-cc13-4675-901c-4756d7f2d45d") /* TPM Memory Clear */))
>                 {
>                     Return (TMCI (Arg1, Arg2, Arg3))
>                 }
> 
>                 If ((Arg0 == ToUUID ("6bbf6cab-5463-4714-b7cd-f0203c0368d4") /* TPM Start Method */))
>                 {
>                     Return (TSMI (Arg1, Arg2, Arg3))
>                 }
> 
>                 Return (Buffer (One)
>                 {
>                      0x00                                             // .
>                 })
>             }
>         }
>     }
> }
> 

> /*
>  * Intel ACPI Component Architecture
>  * AML/ASL+ Disassembler version 20251212 (64-bit version)
>  * Copyright (c) 2000 - 2025 Intel Corporation
>  * 
>  * Disassembling to symbolic ASL+ operators
>  *
>  * Disassembly of ssdt1.dat
>  *
>  * Original Table Header:
>  *     Signature        "SSDT"
>  *     Length           0x00000046 (70)
>  *     Revision         0x02
>  *     Checksum         0x01
>  *     OEM ID           "ACRSYS"
>  *     OEM Table ID     "ACRPRDCT"
>  *     OEM Revision     0x00003000 (12288)
>  *     Compiler ID      "1025"
>  *     Compiler Version 0x00040000 (262144)
>  */
> DefinitionBlock ("", "SSDT", 2, "ACRSYS", "ACRPRDCT", 0x00003000)
> {
>     OperationRegion (MENV, SystemMemory, 0x8AE5CFD8, 0x000C)
>     Field (MENV, AnyAcc, Lock, Preserve)
>     {
>         MERV,   32, 
>         PTTB,   64
>     }
> }
> 

I'm coming from holidays and catching up with matters.

Is the issue still valid?

And don't worry about be first timer if you have actual problems.

BR, Jarkko
