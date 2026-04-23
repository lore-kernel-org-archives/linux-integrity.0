Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DCA36C0C3;
	Thu, 23 Apr 2026 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948652; cv=none; b=mv/jD9rUKYOLQL9rGlh+QyL1rFAfeY/YTH75D1M+n+3e8A5RyB7bl98BYtELGYgzrAbcqgnBcEl/5K9Zjb9+YnE1edQv74/+B+WeTDu74RBDMmHury1ATBIsSXsNJfHR8uMiBBwOtp6ghzBHTFO10piCquFo3+ytnsrZpp+73fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948652; c=relaxed/simple;
	bh=XcCUanrf1pc34/PXuQDdx4vKvmqw9VcBBATWhIcP5R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv6kka2eSIX1ZrMttWedzqdeJ4XNrKDs+ovhcIoVYhz/N/tp4inWrhIj5CvTFVyPuC9imNkOAYLyJaYT8Q34qk+FgoI5lFYywowv1UUPpp69+lmeQNS6GyOoFEHe4YGCTcyVnT8JcdFn4H8L8Qan9uenPR2SXfAaLeakePh15Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkIXBAXE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkIXBAXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5105AC2BCB3;
	Thu, 23 Apr 2026 12:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776948651;
	bh=XcCUanrf1pc34/PXuQDdx4vKvmqw9VcBBATWhIcP5R8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TkIXBAXE2kCqihGQS8ab1gcU7Bn8x/fAv8xmt1AswFSzo9M2bL6sBiEMP9vuXDVae
	 mxRXeRLhhvtqBc7H271KSuxRqHIBbCDh7FSBrrzsl2HlRHA7dsEWcOAttjhVsvfwFN
	 dFstqHVjA2wSYxNz81YfgTMCC0TkRL3rflcCelKxFPni3rT2cLdWfdksvdGQI9xQnG
	 Ojg0uBW7M1uM9Ow3rDHGI5wfjSJY+s+zhcxq/iSCFpv7OQ5Atr2f9r9o9KsKjWM550
	 x+lk52wR1MFcHWCGUdUVQevVTkJ5sqbx1WxYefCBC4cHefforfY8S/SONaSGsqHzLs
	 Q+uwcdKdkvPGg==
Date: Thu, 23 Apr 2026 15:50:47 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Arun Menon <armenon@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [RFC 0/4] tpm_crb: Add command and response buffer chunking
 support
Message-ID: <aeoVp8ScB0ZQqxg2@kernel.org>
References: <20260324071803.324774-1-armenon@redhat.com>
 <acJqVjZ7eSxOpSL5@kernel.org>
 <acKGZ33ItHvMkQ_5@fedora>
 <adYTLq0qgWpA1kIS@kernel.org>
 <aen3zxxedDXlekRb@fedora>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aen3zxxedDXlekRb@fedora>

On Thu, Apr 23, 2026 at 04:13:27PM +0530, Arun Menon wrote:
> On Wed, Apr 08, 2026 at 11:34:54AM +0300, Jarkko Sakkinen wrote:
> > On Tue, Mar 24, 2026 at 06:11:11PM +0530, Arun Menon wrote:
> > > Hi Jarkko,
> > > 
> > > On Tue, Mar 24, 2026 at 12:41:26PM +0200, Jarkko Sakkinen wrote:
> > > > On Tue, Mar 24, 2026 at 12:47:59PM +0530, Arun Menon wrote:
> > > > > The new version of TCG TPM v185 (currently under review [1]) supports
> > > > > sending data/commands in chunks for the CRB (Command Response Buffer)
> > > > > interface. This is in line with the initiative to support PQC algorithms.
> > > > > 
> > > > > This series implements the logic to send and receive larger TPM
> > > > > cmd/rsp between the linux guest and the TPM backend in chunks.
> > > > > Currently, the TPM CRB driver is limited by the physical size of the
> > > > > MMIO window. When userspace attempts to send a payload that exceeds this
> > > > > size, the driver rejects it.
> > > > > 
> > > > > This series introduces chunking support. The driver now checks the CRB
> > > > > interface capability for CRB_INTF_CAP_CRB_CHUNK. If supported by the
> > > > > backend, the driver will slice oversized commands into MMIO-sized
> > > > > chunks, signalling the backend via CRB_START_NEXT_CHUNK, and finalizing
> > > > > with CRB_START_INVOKE. Responses are also read back in a similar chunked
> > > > > manner.
> > > > > 
> > > > > If the backend does not support chunking, the driver retains its legacy
> > > > > behaviour and enforces the standard size limits.
> > > > > 
> > > > > This feature also requires the QEMU to interpret the data in chunks and
> > > > > forward it to the TPM backend and subsequently dispatch the TPM response
> > > > > in chunks back to the linux guest. This is implemented in [2]
> > > > > 
> > > > > [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf
> > > > > [2] https://lore.kernel.org/qemu-devel/20260319135316.37412-1-armenon@redhat.com/
> > > > > 
> > > > > Arun Menon (4):
> > > > >   tpm_crb: Add definition of TPM CRB chunking fields
> > > > >   tpm_crb: Add new wrapper function to invoke start method
> > > > >   tpm_crb: Implement command and response chunking logic
> > > > >   tpm: Increase TPM_BUFSIZE to 64kB for chunking support
> > > > > 
> > > > >  drivers/char/tpm/tpm.h     |   2 +-
> > > > >  drivers/char/tpm/tpm_crb.c | 194 ++++++++++++++++++++++++++-----------
> > > > >  2 files changed, 137 insertions(+), 59 deletions(-)
> > > > > 
> > > > > -- 
> > > > > 2.53.0
> > > > > 
> > > > 
> > > > When QEMU has the feature available?
> > > 
> > > The QEMU patches are in review at the moment,
> > > here is the link: https://lore.kernel.org/qemu-devel/20260319135316.37412-1-armenon@redhat.com/
> > > Hoping to have them merged soon.
> > 
> > Right, and additional question: what about swtpm?
> 
> Hi Jarkko,
> 
> Apologies for the delay in following up.
> Regarding your question about swtpm, I’ve looped in Stefan Berger who 
> should be able to provide more technical context on that front.
> 
> I also wanted to gently point you toward the latest revision of this
> series v2, as I’ve addressed some feedback since our last exchange.
> latest : https://lore.kernel.org/lkml/20260324181244.17741-1-armenon@redhat.com/
> 
> I’ve been working on the QEMU integration side in the meantime to ensure
> the end-to-end flow is solid.
> qemu link : https://lore.kernel.org/qemu-devel/20260422103018.123608-1-armenon@redhat.com/
> 
> I look forward to your feedback when time permits.

Thanks I'll move this to my TODO folder for detailed look. I'm
right now travelling in Hungary but will look in detail next
week.

BR, Jarkko
