Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106633;
	b=noyfntnxfrviy1NuFjouimUus77MAACS+9xO/QE0oozcNOR1RvHxSii7VQ3Hs5LkDemR
	 MHvCNElyUw4eCl6PeFXuBa28pC6qmC5jFHLhNC9I01EnlUiNcDgusJsFhPe3ZsnGTds/+
	 qSe5Nkfcwqf1PxnNA94f8ZkW/5Pac+csBYEzNignO2avBbAhreTRISAqDTKpzCxneCI2x
	 /q1mR0mUmkP+kROmZUCx3+Nr9YIqUzYBWUT6oO3EddrfFXe4cNfYruwE0iny3FpRJGWUc
	 VTYJYvG9l7mhZWtrej5sQkn6ur29/8LUff/HmfBCNAbp8R26ZfnClWv+yXgF4whNwAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106633;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1MHkWmtoDbkxYL8NaThzIQ/ymNf1rAP9merCQQ1YBMs=;
	b=neUQDr8B6hosbC0AZc+z+gQRGB+FeuPvZnTmcujQipr28Ho16kAs52wviihHZFIOYgNa
	 mwLl2hqZknxW7ov+uow7nPcrD1GMMxCPYG95uVlkYNLaBIMsPP33Mhhrsvs+aZJTmVfwA
	 Gfs4GwCmDtVONPldQVjTJBTRn9cy5QTnS8NaBnMeHB//167j6cfdY1sjLllVQcdrAK5Vs
	 ziIH83/Dwno2NkLnZV+847aAER5sTy/gTeF6iNkgYL8xCh8zGUtZZKsPNGn6Y/QieyaIM
	 Um5yngCGw954cPokWVHLZ0rLSBtRYZ9QAfXQjtAvjB0AgMWISZIBo8BybYzLzV/TDBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fWyEx127;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1EA71606A31F;
	Tue, 27 Oct 2026 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fWyEx127
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2C0D91F01825;
	Tue, 27 Oct 2026 13:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106632;
	bh=1MHkWmtoDbkxYL8NaThzIQ/ymNf1rAP9merCQQ1YBMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fWyEx127vm0/A0kbZaBsKqv0EXPhNkOdKc1/WWjYG/xMQoZDbzSt0XjkMN9u6ZImK
	 za1Vc0h+j/MrwhsdvwGtpP6auab9vFOZhj/anElruh0R6MRn0Mn1BLr56G4RtT22jZ
	 k6ktWFgN83S2+MjVRhI1N0XsVQHGmcFyiR1nNX97z/2auoqZq4p+7XEMPCb0j+5vrB
	 lz4+ffZnJaKHl4D1HPrxd5wLlFbNXinKWaqiTBQ6CWXJOfyEGgEeGIQDCvg38kIwgr
	 7yPch5GWPJEg1RxKBWTOom4tSafkhnGk/fxa+ad+3FS9GpwN4NnPogjnjyNgxsQdY/
	 JkXdL/LXSYtbw==
Date: Tue, 27 Oct 2026 15:10:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, sumit.garg@oss.qualcomm.com,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/1] tpm: add TEE driver for a discrete TPM behind OP-TEE
Message-ID: <auCixK7kx1KgKQqt@kernel.org>
References: <20261026163259.1900439-1-jorge.ramirez@oss.qualcomm.com>
 <20261026163259.1900439-2-jorge.ramirez@oss.qualcomm.com>
 <at-y-BtnXX-u67hv@kernel.org>
 <auBfyueV3s_XUS97@trex>
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Post: <mailto:linux-integrity@vger.kernel.org>
List-Help: <mailto:linux-integrity+help@vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-integrity+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auBfyueV3s_XUS97@trex>

On Tue, Oct 27, 2026 at 09:24:42AM +0100, Jorge Ramirez wrote:
> On 26/10/26 22:07:20, Jarkko Sakkinen wrote:
> > On Mon, Oct 26, 2026 at 05:32:48PM +0100, Jorge Ramirez-Ortiz wrote:
> > > Add tpm_dtpm_tee for a discrete TPM that OP-TEE owns and the normal world
> > > cannot reach directly (e.g. an SPI TPM on a bus driven by OP-TEE). The
> > > driver binds to OP-TEE's passthrough pseudo TA by UUID and forwards TPM2
> > > commands through it, presenting a standard TPM2 character device.
> > 
> > "OP-TEE hosts" would be more understandable.
> > 
> > I have trouble following the hops you are doing by speaking about normal
> > world and then jumping into SPI bus. Please try to somehow make this
> > more rigid and less terminology decorated.
> 
> I'd rather keep "owns", not "hosts": OP-TEE does not host this TPM (that
> is the fTPM case, where the TPM runs inside the TEE). Here OP-TEE owns
> the bus controller the chip is wired to, so Linux cannot drive the
> chip.
> 
> That distinction is the reason this is not an fTPM.

OK, so then it would help if it was broken down how these different
components and their interaction work in simple terms.

> 
> > 
> > > 
> > > It is a separate driver rather than a reuse of tpm_ftpm_tee: the TEE
> > > transport is the same, but that driver is tied to the Microsoft fTPM TA
> > > and opens a public-login session, whereas this is a distinct TA for a real
> > > chip, gated to REE-kernel access so that user space and other TAs cannot
> > > reach the TPM. Sharing the fTPM identity would conflate two different
> > > devices and collide on a platform that has both.
> > 
> > And they don't share any of the same DNA?
> 
> Sure, they do. The TEE transport is effectively identical: the
> shared-memory, the invoke and the response validation, plus the
> probe/teardown sequence.
> 
> What differs is the device identity: TA UUID, login (REE-kernel vs
> public), and bind method (ftpm also binds via platform/OF and has a
> shutdown path).
> 
> > 
> > Two other options:
> > 
> > 1. tpm_tis_core type of solution.
> > 2. Implement the feature as part of tpm_ftpm_tee.c.
> 
> I'd rather do (1). The shared transport goes into a small core; the
> per-device identity stays in thin front-ends.
> 
> Something along these lines:
> 
>   /* tpm_tee.h */
>   struct tpm_tee_config {
>           uuid_t  ta_uuid;
>           u32     login;          /* TEE_IOCTL_LOGIN_* */
>           u32     cmd_id;         /* SUBMIT_COMMAND function ID */
>   };
> 
>   int  tpm_tee_core_probe(struct device *dev,
>                           const struct tpm_tee_config *cfg);
>   void tpm_tee_core_remove(struct device *dev);
> 
> 
> tpm_tee_core.c would own everything that is common today:
>  - open context
>  - open session
>  - shm allocation,
>  - chip alloc/register
>  - teardown and so forth
> 
> The front-ends collapse to config plus their own bus binding, e.g.:
> 
>   /* tpm_dtpm_tee.c */
>   static const struct tpm_tee_config dtpm_cfg = {
>           .ta_uuid = UUID_INIT(0x50568cd9, 0x370a, 0x46b8,
>                                0x9f, 0x2c, 0x6f, 0xd9,
>                                0x06, 0x64, 0xd2, 0xee),
>           .login   = TEE_IOCTL_LOGIN_REE_KERNEL,
>           .cmd_id  = 0,
>   };
> 
>   static int dtpm_tee_probe(struct tee_client_device *tcdev)
>   {
>           return tpm_tee_core_probe(&tcdev->dev, &dtpm_cfg);
>   }
> 
>   static void dtpm_tee_remove(struct tee_client_device *tcdev)
>   {
>           tpm_tee_core_remove(&tcdev->dev);
>   }
>   /* id_table + tee_client_driver unchanged */
> 
> 
> I'd push back on (2): one file would carry a public-login firmware TPM
> and a REE-kernel discrete chip, plus it breaks on a platform with both.

Let's write this down to the commit message.

> 
> The core split removes the duplication and avoids that coupling.
> 
> Questions:
> - Is the core in tpm_tee.c / tpm_tee.h acceptable, or do you want a
>   different split.
> 

I'll answer below.

> > 
> > I don't think tpm_ftpm_tee was that great name choice [1] but we have
> > to live with it. 
> > 
> > So more logical name as per taxonomy would be probably
> > tpm_ftpm_tee_dtpm.
> 
> tpm_ftpm_tee_dtpm reads as "firmware TPM ... discrete TPM", which is a
> contradiction (this device is _not_ a firmware TPM)
> 
> Per your own note in [1], the ftpm prefix was a mistake, so extending it
> seems worse than leaving it.
> 
> With the core split this seems clean to me:
> 
>   tpm_tee.c         transport core
>   tpm_ftpm_tee.c    firmware TPM front-end
>   tpm_dtpm_tee.c    discrete TPM front-end
> 
> Does that work? I'm open to another name, as long as firmware vs
> discrete stays visible.

OK so tpm_ftpm_tee is/was a bad name but also renaming modules causes
issues.

It should have probably been "tpm_optee_ftpm".

So I would do instead this:

- tpm_optee -core
- tpm_optee_dtpm -your driver
- tpm_ftpm_tee

I.e. let's accept a glitch but don't repeat the faulty naming pattern.

> 
> The rest I'll take: = {} initalizers (drop the memsets), module name as
> the function prefix, and the MODULE_DESCRIPTION reworded once the layout
> is settled.
> 
> TIA
> jorge
> 

Br, Jarkko
