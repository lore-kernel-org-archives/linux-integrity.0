Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BA12F28EA;
	Mon, 10 Aug 2026 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376097; cv=none; b=K97vrpNwDFTW4wDNuehLPO47RAgY8wKGE0iJ4T/bQmor2YQXct/IVDLSxUVHinNO5DkBtlDYYdvTQfW0S9G+TeB9xCGNwZvppgZyCtmxU6FQIGQPlxzVJL1IXTbr6HuGJSa9hvqNsIfkOf/N8jHf9RQD3L4l3iJ3k3IMOokql+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376097; c=relaxed/simple;
	bh=XG4g1w8x6iXaGHz+7sN/FVmWukP9PtSHG9YwnSKO4Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSl3Wl2NbynshojZqqE4LKu7MAPq1Q7bcXT/KdZVdFL4nX0E0L5PCPHycWB+5ATACyTqWI1lQ4qtWj9KiHPB1Di1NBiqCRQBdGgVNr8qlzaTJPg4vsCNKk0HV32IvV8R9hlG+yiqCg9k/OXZMQw9s2VMnNBW4HuxLpTAAz5Q6qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kid8BZQP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kid8BZQP"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 331951F000E9;
	Mon, 10 Aug 2026 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786376095;
	bh=vUujcqeU9RqDzup5mObSb/OwPHUwpjOJh1YpNI6f5Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kid8BZQPM3JAy53XAQ2Jb6n87I4y9Sz47gHcXyujzS/4AMH2oQtJ79Z4B70t8AJF6
	 WadPGQtF+6IZzCbOfozXD0wpKbTZH580Kkx0as9hWFW0YMsUi2VAnkXV+yJHayg+9c
	 yXNnleB4GEmKn3sY7PARxJ9HGRb8pCgvLFYimNxv56V0C/2XTg/skVz5P31GrpFbLE
	 dgr5kuQ3MJAMNCR5pjRsgHTlqZ4rONgIOkXmFRBWC9ctaDcIezthtcqgPJgwE7/iCN
	 +9R68mD3hxBzR33knPSOEZYuj5qPBNhYaATSmAlGZItV51WltWz/Bt8DvyJX33rfa9
	 FKlmtshgoI4zw==
Date: Mon, 10 Aug 2026 18:34:52 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Julien <julien82453@gmail.com>, regressions@lists.linux.dev,
	linux-integrity@vger.kernel.org,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [REGRESSION] no TPM device after "tpm_crb: Convert ACPI driver
 to a platform one"
Message-ID: <annvnLOa1fSKCXMZ@kernel.org>
References: <CAJOGg3z6LJPDsdPNBxajgy8_wQxfhYBRxe4EiurZf3kPU5A5Bw@mail.gmail.com>
 <f42cc94c-ff60-4999-b473-c2fc5b1b4199@intel.com>
 <CAJZ5v0j1Tucb0yzS8=3U_X1E4ziztjgOsiYrc_QfUUKZfScCPA@mail.gmail.com>
 <CAJOGg3zhEFner5pze-eX+6jh5D8nJppyWkNN5bWtg7MZ7cW9_Q@mail.gmail.com>
 <CAJZ5v0ib2YxyX-6j34=w+FEOH+fsGF_ShH9Q0YCEDkZvRP88EA@mail.gmail.com>
 <CAJZ5v0gySOkYRphXHbXcStFGiuMtni_OWXW2rTDoa_V2PRPnJw@mail.gmail.com>
 <CAJZ5v0i_AS1JzyM10yPfM5QsNVsQmQ3=haHCcTiM72FZm+G+Qg@mail.gmail.com>
 <CAJOGg3wZvftfk-hZ_wXBYnXca9gf5ziSo0Uh1BouYvzoEyEVrg@mail.gmail.com>
 <CAJZ5v0jrvdkjOm75CZSSZmK2ntaVvAN2ru=0yvgXV=twm8uFaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jrvdkjOm75CZSSZmK2ntaVvAN2ru=0yvgXV=twm8uFaA@mail.gmail.com>

On Fri, Aug 07, 2026 at 02:46:16PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Fri, Aug 7, 2026 at 2:26 PM Julien <julien82453@gmail.com> wrote:
> >
> > On Fri, Aug 7, 2026 at 12:45 PM Rafael J. Wysocki (Intel)
> > <rafael@kernel.org> wrote:
> > > And there is a v3 already:
> > >
> > > https://lore.kernel.org/linux-acpi/12955541.O9o76ZdvQC@rafael.j.wysocki/
> > >
> > > so please test this one if possible.
> > >
> > > Thanks!
> >
> > Yes it still works.
> >
> > The logs:
> > MSFT0101:00: [mem 0xfed40000-0xfed4103f] expanded to avoid overlap
> > tpm_crb_acpi MSFT0101:00: [Firmware Bug]: Bad ACPI memory layout
> 
> Thanks for the confirmation!

I'll check your patch asap. Sorry for latency, it's the holiday season
in Finland.

BR, Jarkko
